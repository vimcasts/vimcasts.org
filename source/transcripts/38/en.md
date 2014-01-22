## Using markers for folding

Here's an excerpt from a `vimrc` file. The comments hint at some kind of structure: we have a section where preferences are set, and another where custom mappings are defined. Let's add some fold markers to describe this heirarchy.

Before we begin, I'm going to set the `foldcolumn` option to three:

    set foldcolumn=3

Pay attention to the gutter containing the line numbers. When I apply this setting, the gutter becomes wider by three columns. There's nothing to see there yet, but we'll soon change that.

Next, we're going to set the `foldmethod` option to `marker`:

    set foldmethod=marker

We still have no visible changes, but now we can insert markers into the document that instruct Vim to start and end folds.

Let's try it. The default syntax for starting a fold is three consecutive opening curly braces. I'll insert them here, to create a fold for the last section. The foldcolumn in the gutter indicates that something has happened, and if I press `za` I can toggle this new fold closed and open.

Now let's try inserting the same marker to create a fold for the top section. If we close this new fold, it collapses everything up to the end of the file. Looking at the notation in the foldcolumn, it appears that our new fold *contains* the one below it.

By the way, this notation illustrates the `foldlevel` of each line by the number of pipe symbols. A dash symbol indicates where a fold begins.

That's not the effect I'm looking for. I'd prefer to have these two sections as siblings: equals in the document heirarchy. There are a couple of ways that we could do this.

We could manually close the first fold, by inserting three consecutive closing curly braces. Looking at the foldcolumn, you can see the effect of this immediately, but I can also demonstrate by pressing `zM` to close all folds. The two sections now sit alongside one another.

This produces the desired effect, but I don't relish the idea of having to manage closing markers as well as opening markers. Let's revert that change. An alternative approach is to explicitly specify the foldlevel when you create a fold, by appending a digit.

When we explicitly create a new level-one fold, Vim automatically closes any level one folds that were already open. This also produces the desired effect.

When the `{{{` (opening marker) is given without a digit, it simply instructs Vim to add one to the current foldlevel. In this case, the document starts of with `foldlevel=0`, so this opening marker works fine. Let's make that one explicit too.

Next, we can add more structure to our document by adding a level two fold marker to delimit these subsections. Keep an eye on the foldcolumn as I add each of these markers.

Now if I collapse all the folds with `zM`, I can drill down one fold at a time.

If I close Vim and launch again with the same file, the folding behaviour appears to have gone away. That's because Vim's default `foldmethod` is `manual`. 

    :set foldmethod?
    manual

We can use a modeline to tell Vim that we always want to use the marker foldmethod with this file. 

    " vim: nowrap fdm=marker

Now if I quit Vim, and reopen it with the same file, the folding kicks in as it did before.

In general, I don't encourage using modelines and foldmarkers, because I believe that source code should leave no clues as to which text editor was used in its creation. But Vimscript files are one of the few places where these techniques are admissable. It's safe to assume that anyone interested in the contents of a Vimscript file is probably using Vim anyway.

Duration: 4:20

## Using markers with Markdown (not recommended)

I have a markdown file here, and I'd like to be able to fold it so that I can navigate its sections more easily. I could apply the exact same technique as we used for the vimrc file, by setting the foldmethod to marker:

    :set foldcolumn=3
    :set foldmethod=marker

Then adding markers for the level one and level two headings:

		:g/^#/normal A {{{1

Here I'm using the `:global` command to append a level-one marker at the end of every line that begins with a hash symbol.

Now we can fold away all of the sections, leaving only an outline of headings. That's useful, but you don't really want to litter your markdown files with these markers. After all, if this document was compiled to HTML, the markers would end up in the output.

But if we look at the structure of this document, it's easy to describe the pattern that we want the folds to trace: for each line that begins with a hash symbol, create a new fold. Now let's write an expression that makes this happen.

## Creating a script to define foldexpr

We want to apply our expression to markdown files, so we'll create a file with the path:

    :e ~/.vim/after/ftplugin/markdown/folding.vim

This file will be sourced automatically each time we open or create a markdown file.

## The mechanics of a fold expression


We'll start off with a little boilerplate code, which instructs Vim to use a custom expression to generate the folds for a document.

    function! MarkdownFolds()
      return "0"
    endfunction
    setlocal foldmethod=expr
    setlocal foldexpr=MarkdownFolds()

Let's save this buffer, then switch back to the markdown file. I'm going to call `:edit!`, which reverts my unsaved changes (removing the markers), and sources the folding script. Now the foldmethod is set to `expr`, and the foldexpression is set to our custom function.

    :set foldmethod?
    expr
    :set foldexpr?
    MarkdownFold()

This is how it works: the `MarkdownFolds()` function is called one time *for each line* in the document. If the function returns zero, it indicates that the line is not part of a fold. If the function returns one, it indicates that the line has a fold level of one. Let's change this function so that it always returns one, and see what happens...

I'll run the `:edit` command with no arguments to reload the current buffer, and that should apply the updated fold expression. Now every line in the file reports that it has foldlevel equal to one, so we get one giant fold. That's not very useful, but we're making progress.

## A foldexpression for flat folds

What we really want is to *open a new* level-one fold for each line that begins with a hash symbol, and to do that, we need to examine the contents of each line.

We can get the contents of the current line by calling the `getline()` function, and passing it the `v:lnum` variable. This is a special read-only variable that Vim predefines for us when calling a foldexpression function.

    let thisline = getline(v:lnum)

Now we can simply check whether `thisline` matches against a regular expression:

    if match(thisline, '^#') >= 0
      return ">1"
    endif
    return "1"

If we return one, it tells Vim that thisline has a foldlevel of one. But if we return greater-than-one, it tells Vim that thisline *starts* a level-one fold. As we saw before, when a levelone fold begins, Vim automatically closes any folds that came before it.

The equals sign has a special meaning in this context: it tells Vim that thisline should have the same foldlevel as its predecessor.

    if match(thisline, '^#') >= 0
      return ">1"
    else
      return "="
    endif

Let's save that foldexpression, and reload our markdown file. How about that? Each header line creates a new level-one fold. The result is just the same as when we used markers, except we haven't had to pepper the document with unwanted symbols.

## A foldexpression for nested folds

With the document completely folded, we get an overview that resembles a table of contents. It shows all h1 and h2 titles, and it would show h3s and beyond if this document contained them.

There's an implicit heirarchy in this outline. Let's change our fold expression so that it tests first to see if a line begins with two hashes. In that case, it starts a level-two fold.

    if match(thisline, '^##') >= 0
      return ">2"
    elseif match(thisline, '^#') >= 0
      return ">1"
    else
      return "="
    endif

When we re-load our markdown document, the folding structure reflects the heirarchy of the document: with h2 sections nested beneath h1s.

## Setting the foldtext

For each of these folds, Vim shows the text of the first line, and the number of lines that have been hidden. We can customize this by defining a second function, then assigning it to the `foldtext` option:

    function! s:MarkdownFoldText()
      return getline(v:foldstart)
    endfunction
    setlocal foldtext='MarkdownFoldText()'

We can get the line numbers of the first and last lines for the current fold from two read-only variables: `v:foldstart` and `v:foldend`. We could use these, for example, to calculate the number of lines that the fold contains. Then we could include that in the foldtext.

    function! s:MarkdownFoldText()
      let foldsize = (v:foldend-v:foldstart)
      return getline(v:foldstart).' ('.foldsize.' lines)'
    endfunction

Let's switch to the markdown file and reload the folding plugin... and there we go: our custom foldtext has been applied.

## Markdown-folding plugin

I've written a plugin that encapsulates the ideas demonstrated in this tutorial. It supports both the flat and nested folding styles, with a toggle command that lets you easily switch between them. Also, it recognises both of Markdown's heading styles: with hashes or an underline.

I hope that this tutorial has demonstrated that it's pretty easy to create a custom folding expression. If you often work with a language or library that doesn't have folding support baked in to Vim, I encourage you to try writing a folding expression of your own.
