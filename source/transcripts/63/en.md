### Operating with gn

In this text, I'd like to change each occurrence of the word `Normal` to `Visual`.
In Vim, when we want to change a word, a common pattern is to use `cw`.
But in this case, that deletes too much (I'll undo that).
So how else could we do it?

One solution would be to press `6s` - which deletes 6 characters and switches to Insert mode. That works, but in general I prefer to avoid counting characters (I'll undo that change).
Another approach would be to use the `f` motion, to change up to (and including) the `l` character, which is the last letter of the region we want to delete.

It would be great if we could just tell Vim to change the highlighted search match.
Since version 7.4 of Vim, we can do this using the `gn` motion: which selects the next search match.

    :h gn

Pressing `cgn` tells Vim to change the next search match. That's a much neater solution!

Now I could jump to the next match with `n` and repeat the change with dot, again and again. That's a pretty familiar workflow. But in this case we can shave off one more keystroke. (Let me just undo those changes...)

The dot command repeats the last change, which in this case can be read as: "change the next match". We don't even need to have our cursor on the match for this to work! So we can finish the job just by pressing dot once for each change.

### Using gn to select the next match

The `gn` command can be used as a motion following operator commands such as `d`, `c`, `y`, and so on. But we can also use it in Normal mode.
You know how pressing `n` tells Vim to jump to the start of the next match?
Well, `gn` tells Vim to start visual mode and select the next match.
And as you might expect, the `gN` gee-shift-N command lets you visually select the previous match.
When used in this fashion, the `gn` command makes Vim's search behave like most graphical text editors, where the search command selects the current match.

### Variable length matches

The `gn` command really comes into it's own when we search for a regular expression that matches text regions of variable length. For example, here I have a document with variables that begin both Xml and Xhtml. I can prepare a search pattern that matches both words:

    /\vX(ht)?ml\C

Some of the matches are 3 characters long, while others are 5 characters long. But that doesn't matter if we operate on them using `gn`.

    :h gU

Suppose, for example, that we wanted to transform both Xml and Xhtml to uppercase. We could do so with the `gU` gee-shift-you operator. Pressing `gUgn` gee-shift-you-gee-N instructs Vim to upcase the next search match.

Pressing dot repeats the change, and with only a few keystrokes the remaining edits have been completed.

### Practical Vim

In the 1st edition of Practical Vim, tip 84 goes over a different approach for making this same kind of change, which is nowhere near as tidy! When I wrote this edition, the `gn` feature hadn't yet been added to Vim. I'll have to revise this tip when the time comes to write a new edition of Practical Vim.

