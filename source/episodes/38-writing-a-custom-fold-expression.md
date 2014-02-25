--- 
:title: Writing a custom fold expression
:date: 2012/11/26
:poster: /images/posters/custom_foldexpr.png
:flattr_id: "1033505"
:duration: 727
:number: 38
:tags: folding
---

With a little bit of Vimscript, you can create a custom folding expression for any filetype. We'll start by looking at the mechanics of folding with markers, then go on to create a folding expression for markdown documents.

READMORE


Here's [a gist of the markdown folding expression][gist] that was created in the video. 

## Creating an ftplugin

Create a filetype plugin for markdown files as follows:

    mkdir -p ~/.vim/after/ftplugin/markdown
    vim ~/.vim/after/ftplugin/markdown/folding.vim

You can replace `markdown` with the name of any other language to create a filetype plugin for that language instead.

## The mechanics of a `foldexpr`

Here's the boilerplate fold expression that we used to begin with:

    function! MarkdownFolds()
      return "0"
    endfunction
    setlocal foldmethod=expr
    setlocal foldexpr=MarkdownFolds()

It works like this: the `MarkdownFolds()` function is called one time *for each line* in the document. If the function returns `"0"`, it indicates that the line is not part of a fold. If the function returns `"1"`, it indicates that the line has a fold level of one. Here are a few more values that can be returned from a fold expression, with their meanings:

<table>
    <tr>
        <th>value</th>
        <th>meaning</th>
    </tr>
    <tr>
        <td><code>"0"</code></td>
        <td>the line is not in a fold</td>
    </tr>
    <tr>
        <td><code>"1", "2", ...</code></td>
        <td>the line is in a fold with this level</td>
    </tr>
    <tr>
        <td><code>"="</code></td>
        <td>use fold level from the previous line</td>
    </tr>
    <tr>
        <td><code>"&gt;1", "&gt;2"</code></td>
        <td>a fold with this level starts at this line</td>
    </tr>
</table>

For a complete list of values that can be returned by a fold expression, look up [`:help fold-expr`][fold-expr].

Inside of a fold expression, we can use the [`v:lnum`][v:lnum] variable to access the line number of the current line that is being evaluated. This can easily be combined with the [`getline()`][getline] function to get the *contents* of the current line that's being evaluated.

## Customizing the `foldtext`

We can customize the way that a fold looks by way of the [`foldtext`][foldtext] option. Here's the boilerplate foldtext expression that we used to begin with:

    function! MarkdownFoldText()
      return getline(v:foldstart)
    endfunction
    setlocal foldtext=MarkdownFoldText()

Inside of a foldtext expression, we can use the [`v:foldstart`][v:foldstart] and [`v:foldend`][v:foldend] variables, which reference the line numbers of the first and last lines that make up the current fold.

## Further Reading

* [`:help fold-expr`][fold-expr]
* [`:help fold-marker`][fold-marker]
* [`:help foldcolumn`][foldcolumn]
* [`:help fold-foldcolumn`][fold-foldcolumn]
* [`:help v:lnum`][v:lnum]

In preparing this material, I took inspiration from several sources, including:

* [gist from Steve Losh][gistsjl]
* [Basic folding][48] chapter from Learn Vimscript the Hard Way
* [Advanced folding][49] chapter from Learn Vimscript the Hard Way
* [Vim Markdown Folding?][q] on Stack Overflow


[foldcolumn]: http://vimdoc.sourceforge.net/htmldoc/options.html#'foldcolumn'
[fold-foldcolumn]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-foldcolumn
[fold-expr]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-expr
[fold-marker]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-marker
[v:lnum]: http://vimdoc.sourceforge.net/htmldoc/eval.html#v:lnum
[v:foldstart]: http://vimdoc.sourceforge.net/htmldoc/eval.html#v:foldstart
[v:foldend]: http://vimdoc.sourceforge.net/htmldoc/eval.html#v:foldend
[getline]: http://vimdoc.sourceforge.net/htmldoc/eval.html#getline()
[foldtext]: http://vimdoc.sourceforge.net/htmldoc/options.html#'foldtext'
[gist]: https://gist.github.com/4149842

[gistsjl]: https://gist.github.com/1038710
[q]: http://stackoverflow.com/questions/3828606/vim-markdown-folding
[48]: http://learnvimscriptthehardway.stevelosh.com/chapters/48.html
[49]: http://learnvimscriptthehardway.stevelosh.com/chapters/49.html
