> Vim's substitute command is not interactive.

When we use the `:substitute` command, we first type out the pattern, then the replacement text, but it's only when we press the enter key that any changes are made to our document.

    :s/not/not really

> Vim's substitute command is not really interactive.

It's not really interactive.

    :help inccommand

In Neovim, we can set the `inccommand` option so that we get interactive feedback *as we compose* our substitute command.
Let's try this out.

We'll set the `inccommand` to `nosplit`:

    :set inccommand=nosplit

Now let's use the substitute command to change this text:

    :s/not really/totally

Notice that as I type the search pattern, the first match gets highlighted.
And when I type the replacement field, the document is modified live.

If I press the `escape` key, the substitute command is aborted and the document instantly reverts to how it looked before.
Or if I press the `enter` key, the substitute command is executed and the changes persist.

### Changing flags and patterns

Let's look at a slightly more complex example.
Suppose that we want to modify this text so that the word 'branch' is changed to 'stick':

> A pattern is one or more branches, separated by "\|".  It matches anything that matches one of the branches.  Example: "foo\|beep" matches "foo" and matches "beep".  If more than one branch matches, the first one is used.

We'll type out a basic version of the substitute command:

    :s/branch/stick

Without even executing the command, we can see that it will modify the first occurrence, but it will leave the other matches unchanged.
Let's add the `g` flag:

    :s/branch/stick/g

Now our command will change all occurrences on this line.

But there's a wrinkle with this example: some of the matches are plural, some are not.
The plural of 'sticks' should not have an `e` before the `s`.

Let's back up and modify our pattern so that it optionally matches the `e` character:

    :s/branche\?/stick/g

Now our substitute command correctly handles the plural and singular cases, so we'll press enter to finalise the changes.

### Previewing changes in a split window

Here's a document that spans multiple lines.
Let's change every occurrence of the word `pattern` to `shape`

    :%s/pattern/shape/g

The live feedback works just as you'd expect in this case too.
But note that there are some matches that we can't see because they are off-screen.

I'll just undo that last change...

Now let's change the `inccommand` setting to `split`:

    :set inccommand=split

We'll type out the same substitute command as before.
This time, a temporary split window appears, showing the first few lines that match the pattern.
This lets us preview changes that would happen to parts of the document that are not currently visible.

## Highlighting the yanked text

Suppose that we want to yank the text inside these quotes:

    call minpac#add('tpope/vim-surround')

We can do so by pressing `yi'` "wye-eye-single-quote".
And if we inspect the yank register:

    :reg 0

We can check that it worked.

Vim doesn't give much in the way of feedback when we perform a yank operation like this.
The document doesn't change.
The cursor ends up on the first character of the text that was yanked, so if it wasn't already there before you did the operation then that movement gives you a clue that your keypresses actually did something.
But that's not a lot to go on!

The highlightedyank plugin changes this behaviour by briefly applying a highlight to the region of text that was yanked.

Let's quickly install it:

    call minpac#add('machakann/vim-highlightedyank')

    :w
    :source %
    :call minpac#update()

...and restart Neovim.

This time when we use the `yi'` "wye-eye-single-quote" command on the same example, the range of text is briefly highlighted.

I find this especially useful if I'm using the yank command with a text object.
Observe the difference when I use `yi)` "wye-eye-paren"
Or `ya)` "wye-ay-paren".

Since installing this plugin I've been surprised by how much I've come to like it.
I find it reassuring to see the highlight when I yank text.

You can use the highlightedyank plugin in both Vim and Neovim.
To make it work in Vim, you have to remap the `y` command.
In Neovim this is not necessary.
That's because Neovim provides an autocommand called `TextYankPost`.

    :h TextYankPost

The highlightedyank plugin uses this hook to trigger the highlight.

