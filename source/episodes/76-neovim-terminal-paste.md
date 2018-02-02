---
:title: Pasting into a terminal buffer
:date: 2018/02/02
:poster: /images/posters/neovim-terminal-paste.png
:duration: 345
:number: 76
:tags: Neovim, Terminal Emulator, Copy and Paste
---

Yanking and pasting works seemlessly between Neovim's regular buffers and terminal buffers.
In this video, we'll look at how the Normal mode paste command works in a terminal buffer, and we'll create a mapping to help with pasting text directly from Terminal mode.

READMORE

Suppose that you've opened a regular text buffer containing a `README.md` file, which lists a series of commands that you want to run in a shell.
In another split, you've got a terminal buffer containing a shell.
You can activate the text buffer and use the `"ay` command to yank the text.
Then activate the terminal buffer and use the Normal mode `"ap` command to insert the text into the shell's command line.
To execute that command line in the shell, you could then press `i<Enter>`.
(`i` switches to Terminal mode, then the shell receives the `<Enter>` key which executes the command line.)

### How does a terminal buffer handle pasted text?

If you followed the example above, you could come away with the impression that there's nothing special about using the `p` command in a terminal buffer.
But you should be aware of some of the differences in how the `p` command works in a terminal buffer, compared with a regular buffer.

In a regular buffer, the `p` command pastes text at the cursor position.
(To split hairs: lowercase `p` pastes after the cursor, whereas uppercase `P` pastes before the cursor.)
In a terminal buffer, the `p` command pastes text at the location of the *terminal cursor*, which is distinct from the *normal cursor*.
So what's the difference?

Suppose that you have a bash shell running inside of a terminal buffer.
In this scenario Neovim has a cursor and Bash has a cursor.
When you're in Normal mode, you can use Neovim motions such as `j`, `k`, `w`, `b` to move Neovim's cursor.
When you're in Terminal mode, you can use readline bindings such as `<C-a>`, `<C-e>`, `<A-f>`, `<A-b>` to move Bash's cursor.
When you use the Normal mode `p` command, Neovim sends the text from the register to the underlying program, just as if you had typed the characters by hand in Terminal mode.
In this context, the outcome is that the text from the register gets inserted into the bash shell at the location of the bash cursor.

### Making the terminal cursor visible

You can style the appearance of the terminal cursor using the [TermCursor][] and [TermCursorNC][] highlight groups.
The `TermCursor` style applies when you're in Terminal mode, otherwise the `TermCursorNC` style is used (**NC** stands for *Non-Current*).
If your colorscheme doesn't specify styles for these highlight groups, then it can be hard to tell where the text is going to appear when we use the `p` command.

You can make your terminal cursor more visible using this quick fix:

    :hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

A more long-term solution would be to add suitable styles to your preferred colorscheme.
I'm currently enjoying using the [solarized8][] theme, which [defines styles for Neovim's terminal][solarized8-cursors].

### Pasting in terminal mode

In Insert mode, you can use [`<C-r>{reg}`][ctrlr] to insert the contents of a register.
However, this command *does not* work in Terminal mode.
Remember: in Terminal mode, all keystrokes are forwarded to the program that's running inside of the terminal buffer.
For example, if you're running a bash shell (with readline default bindings) inside a terminal buffer, then pressing `<C-r>` will invoke the [*reverse incremental search*][reverse-search-history] feature.
It would be handy if you could paste text straight from Terminal mode.

You can create a mapping to add this functionality:

```vim
if has('nvim')
  tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
```

After loading this mapping, you can insert the contents of a register in Terminal mode by pressing `<A-r>{reg}`.
If you'd prefer to make this mapping resemble the Insert mode mapping, you could instead bind it to `<C-r>`, but that would mean that you couldn't send `<C-r>` to the program running inside the terminal buffer.

### Further reading

* [`:h terminal-input`][terminal-input]
* [`:h TermCursor`][TermCursor]
* [`:h TermCursorNC`][TermCursorNC]
* [`:h i_CTRL-R`][ctrlr]
* [solarized8 theme][solarized8]

[terminal-input]: https://neovim.io/doc/user/nvim_terminal_emulator.html#terminal-input
[TermCursor]: https://neovim.io/doc/user/syntax.html#hl-TermCursor
[TermCursorNC]: https://neovim.io/doc/user/syntax.html#hl-TermCursorNC
[solarized8]: https://github.com/lifepillar/vim-solarized8
[solarized8-cursors]: https://github.com/lifepillar/vim-solarized8/blob/a534e726e55ce478875ffc19e39164ffacb83f8f/colors/solarized8.vim#L377-L379
[ctrlr]: https://neovim.io/doc/user/insert.html#i_CTRL-R
[reverse-search-history]: https://www.gnu.org/software/bash/manual/html_node/Commands-For-History.html#Commands-For-History
[registers]: https://neovim.io/doc/user/change.html#registers
