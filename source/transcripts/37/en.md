# Methods of folding

Vim has several different methods for folding a document. You can read more about them by looking up the help for `fold-methods`.

    :help fold-methods

I don't want to go into much detail about these different methods, except to say that I've found using a custom fold expression to be the most useful method by far.

For the purposes of this demonstration, I'm going to use a markdown file. The folding behavior is provided by a plugin called `markdown-folding`. You'll find a link for it in the show notes. In the next episode, we'll look at how the markdown folding expresion is implemented, but for now I just want to focus on how to use folding.

# Turning folding on and off

Here we have a markdown document with a series of level one and level two headings. It's fully expanded right now, because I've disabled the folding feature. I can toggle the folding behavior on and off by using the `zi` command. Put that one at the top of your cheat sheet. If you can only remeber one folding command, it should be how to turn the feature off and on again.

With folding enabled, every section of the document that begins with a header is folded away so as to only take up a single line. The result is that we can see an outline of the entire document. You can look on this as being like a table of contents, generated from your section headers.

# Navigating the unfolded document

Even when the document is fully unfolded, the fact that Vim knows where the folds start and finish gives us an additional method for moving around.

If we prefix the `j` motion with the letter `z`, then Vim will move down to the top of the next fold. In this case, the `zj` motion doesn't cover a lot of ground because my sample document contains very short sections. But you can imagine how useful this could be in a genuine markdown document.

The `zk` motion moves up to the bottom of the previous fold.

With these motions, we can rapidly navigate the sections of a document. 
Our custom fold expression adds a whole new layer of semantics, which allows us to rapidly navigate the sections of the document.

# A folded section behaves like a line of text

Suppose that we wanted to delete one of these sections. If we didn't have folding, we could use visual mode to select each line, then delete the selected text. But there's an easier way. (I'll just undo that change).

If we fold away the section that we want to delete, it collapses down to one line. We can treat it just as though it were a single line of text. That means we can use the `dd` command to delete it. We could even use the `p` command to paste the section that we just deleted.

Suppose that we wanted to take these three h2 sections, and move them down to just before the next h1 section. It's as easy as cutting and pasting 3 lines of text!

# Opening and closing folds

So far, we've had the document completely folded or completely open, but of course we can have more granular control too. Vim provides about a dozen commands for opening and closing folds, but I get by using just a handful of them. I want to show you some of the most useful ones.

## Toggle current fold (`za`)

The `za` command toggles the current fold between open and closed states. 

You might want to consider mapping this command to something more convenient, so that it can be invoked with a single keystroke. Steve Losh suggests this mapping, which makes the spacebar toggle the current fold:

    nnoremap <Space> za

Using this mapping, I can quickly look inside a fold, then close it with a single keystroke.

For a simple document such as this, where all of the folds are at the same level, you can get by fine with only the `zi` and `za` commands.

Now let's add a little bit of complexity by switching to an alternative folding expression that gives us a hierarchical outline of the document.
The markdown-folding plugin provides a `:FoldToggle` command, which changes the folding style:

    :FoldToggle

All we can see now is the level 1 headers, and if I open one of these (using the `za` command) then we can see each of the level 2 headers nested within.

I'll drill down and open up one of these level 2 headings. Now watch what happens when I use the `za` command: it toggles the fold at the current cursor position. But what if I want to close the parent fold: the level 1 heading?

Well, I could do it with the `za` command, but I would first have to move my cursor.

## Close current fold (`zc`)

In this case, it would be quicker to use the `zc` command, which *closes* the current fold. If the current fold is already closed, then it will attempt to close the parent fold instead.

I find that the `za` command serves well for drilling down into nested folds, but if I want to close the folds I'll often reach for the `zc` command instead.

## Refocus folds

Vim's folding commands operate at a low level. Sometimes, we have to chain a couple of these low level commands together to produce the desired result. I want to show you an example of what I mean.

We'll start off with the document completely folded. Now suppose that we want to jump to part of the document that discusses 'repetition'. We start off by searching for that word:

    /repetition

Each time I press the `n` key, Vim jumps to the next match, and opens any folds containing the match. In this case, we have uncovered two matches. Now let's suppose that this is the one that we were looking for. It's a bit annoying that the other section has been unfolded, even though we don't want to look at it.

There's a quick way of tidying up in this scenario: `zMzv`. That's two separate commands, and a total of four keystrokes. The result is that all folds are collapsed, except for the ones containing the current line that the cursor is on.

The `zM` command closes all folds in the document, then the `zv` command expands the folds to reveal the cursor position.

[zM]

Let's try that again, but this time slowly. I'll press `n` to expand each of the sections containing a match for our search term. This time, note that the cursor is positioned on line 31. `zM` closes everything. Even though it looks as though the cursor is on line 17 - the top of the parent fold - it hasn't actually moved from line 31. And when I press `zv`, the folds open to reveal the cursor position.

## Miscellany

Don't try to memorize all of Vim's folding commands at once, there are too many! I recommend starting out with these few commands, which cover most use cases.

In the next episode, we'll find out how to implement a custom folding function from scratch.


## Outro

The information in this video is summarized in the accompanying shownotes. If you have any questions, requests or recommendations, then you can contact me at drew at vimcats dot org.
