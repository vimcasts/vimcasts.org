--- 
:title: Operating on search matches using gn
:date: 2014/02/11
:poster: http://vimcasts.org/images/posters/gn-command.png
:flattr_id: ""
:duration: 275
:number: 63
:tags: Visual mode, search, Repetition, Regular expressions, Vim 7.4, Editing text
---

The `gn` command (introduced in Vim 7.4) makes it easy to operate on regions of text that match the current search pattern. It's especially useful when used with a regex that matches text regions of variable length.


READMORE

Here's what Vim's documentation has to say about the `gn` command ([`:help gn`][gn]):

> Search forward for the last used search pattern, like with `n`, and start
> Visual mode to select the match. If the cursor is on the match, visually
> selects it. If an operator is pending, operates on the match.

You know how pressing `n` tells Vim to jump to the start of the next match?
Well, `gn` tells Vim to start visual mode and *select the next match*.
When used in this fashion, the `gn` command makes Vim's search behave like most graphical text editors, where the search command selects the current match.
As you might expect, the `gN` command lets you visually select the previous match.

I find the `gn` command especially useful in [Operator-pending mode][]. For example, `dgn` will delete the next match, `cgn` will do the same then switch to Insert mode, `gUgn` will convert the next match to uppercase characters.
Look up [`:h operator`][operator] for more ideas.

### Using `gn` with the dot command

Suppose that we have a document containing several occurrences of the word 'Normal' and we'd like to change each occurrence to 'Visual'.
We can run `/Normal` to search for the word 'Normal', then type `cgnVisual<Esc>` to change the next match to the word 'Visual'.
You're probably familiar with the technique of pressing `n.` to repeat the change for each subsequent match. In [Practical Vim][], I call this pattern of usage *The Dot Formula*.
It lets us use two keystrokes per change.

In this context, we can do better.
The dot command repeats the last change, which is equivalent to typing `cgnVisual<Esc>`.
We could translate that into plain English as: "change the next match".
We don't have to press `n.` because `.` does the job by itself.
That makes it just one keystroke per change!

### You need Vim 7.4.110 to use `gn`

You can use the `gn` command if you are running Vim 7.4 at [patch level 110][110] or greater.

The `gn` feature was first introduced by Christian Brabandt in Vim 7.3 with patch [610][], then the functionality was refined with patches [625][], [636][], [645][], [647][], and [1275][]. The feature was made widely available in Vim 7.4, but if you are running a version less than patch level 110 then the `gUgn` command demonstrated in this video won't work.

### Practical Vim - tip 84

In the 1st edition of [Practical Vim][], tip 84 goes over a different approach for making this same kind of change, which is nowhere near as tidy! When I wrote this edition, the `gn` feature hadn't yet been added to Vim. I'll have to revise this tip when the time comes to write a new edition of Practical Vim.

If you're stuck on an older version of Vim, note that you can get similar functionality by installing the [textobj-lastpat][] plugin by Kana Natsuno.
I used to consider this to be an essential plugin, but don't now that the `gn` command is built-in to Vim.

### Further reading

* [`:help gn`][gn]
* [`:help operator`][operator]
* [`:help .`][dot]
* [Practical Vim][], tip 84: Operate on a complete search match

[gn]: http://vimhelp.appspot.com/visual.txt.html#gn
[operator]: http://vimhelp.appspot.com/motion.txt.html#operator
[changed-7.3]: http://vimdoc.sourceforge.net/htmldoc/version7.html#changed-7.3
[610]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.610
[625]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.625
[636]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.636
[645]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.645
[647]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.647
[1275]: http://ftp.vim.org/pub/vim/patches/7.3/7.3.1275
[110]: http://ftp.vim.org/pub/vim/patches/7.4/7.4.110
[Practical Vim]: http://pragprog.com/book/dnvim/practical-vim
[Operator-pending mode]: http://vimdoc.sourceforge.net/htmldoc/intro.html#Operator-pending-mode
[textobj-lastpat]: https://github.com/kana/vim-textobj-lastpat
[dot]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#.
