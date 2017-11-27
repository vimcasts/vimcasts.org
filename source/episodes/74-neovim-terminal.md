---
:title: Neovim's terminal emulator
:date: 2017/11/28
:poster: /images/posters/neovim-terminal.png
:duration: 365
:number: 74
:tags: Neovim, Terminal Emulator
---

Neovim lets you run a [terminal emulator][terminal_emulator] inside of a buffer. In this video, we'll cover some of the basics of how terminal buffers work, and how you can use them alongside regular buffers in your workflow.

READMORE

### The `:terminal` command

In Neovim, you can open a terminal buffer using the command:

    :terminal

By default, that will open a terminal buffer running your default shell.
Alternatively, you can specify the program that you want to run when in the terminal buffer by providing an argument. For example, to run `top` or launch a rails server:

    :terminal top
    :terminal rails server

You can’t modify the text in a terminal buffer directly. Instead, the text is updated asynchronously by the program running inside the terminal buffer. You can interact with the program running inside the terminal buffer by switching to *Terminal Mode*.

### A new mode: Terminal Mode

Vim users are accustomed to spending most of their time in **Normal mode**, with brief forays into **Insert mode**, **Command-line mode**, **Visual mode**, and [other modes][modes].
In Neovim, you get a new mode to play with: **Terminal mode**. In this mode, you can interact with programs that run inside the built-in terminal emulator.

Terminal mode is only available in terminal buffers, where you can activate the mode by pressing `i`, `a`, `I`, or `A`.
In a regular text buffer, these same commands would switch to Insert mode, but that mode is not available in a terminal buffer.

In Terminal mode: **all keystrokes are forwarded to the underlying program**.
There's one single exception to that rule: pressing `<C-\><C-n>` switches you back to Normal mode.

In the same way that [`nnoremap`][nnoremap] lets you create mappings for Normal mode, [`inoremap`][inoremap] lets you create mappings for Insert mode, and so on, you can also create mappings for Terminal mode using [`tnoremap`][tnoremap].
That's what makes Terminal mode truly a *mode*
We'll explore this capability in greater detail in another episode of Vimcasts.

### Using Normal mode in a terminal buffer

In a terminal buffer, most Vim commands work just fine.
You can move the Normal mode cursor around using motions such as `h`, `j`, `k`, `l`, `w`, `b`, etc.
You can scroll the screen using `<C-f>`, `<C-b>`, `<C-d>`, and `<C-u>`.
If the terminal buffer contains a filepath, you can place your cursor on it and use `gf` to open that file in a regular buffer.
You can use `y` and `p` to copy and paste text in a terminal buffer (we'll explore this in more detail in another episode).

Any command that would normally *edit text* in a buffer won't work in a terminal buffer.
For example,  if you try running `dd`, or `cw`, or `x`, Neovim will show the error message: `E21: Cannot make changes, 'modifiable' is off`.
I find that it helps to think of terminal buffers as being read-only, from Neovim's perspective.

### Killing processes in terminal buffers

There are various ways that you can kill the process running in a terminal buffer.
The best way is to run `:bdelete! [N]` (the `!` is required), where `N` is the number of the buffer you want to delete. You can find out the buffer number by inspecting the output from the `:ls` command.

Alternatively, you can activate the terminal buffer and switch to Terminal mode, then send a kill signal (or interupt signal) directly to the program.
In many cases, `<C-c>` will do the trick, but some programs handle this differently.

Finally, when you quit Neovim, any remaining terminal buffers will be wiped out, causing their associated programs to exit.

### What about the `:terminal` in Vim 8?

This video covers the `:terminal` feature in Neovim.
Since I recorded this video, work has started to add a `:terminal` command to Vim 8.
This has some similarities with the Neovim implementation and some important differences.
**Be warned**: I don't expect the instructions given here to work in Vim 8.

The last time I tried using the `:terminal` in Vim 8, it was a long way from being ready.
I'm watching the development of that feature with interest.

### Further reading

* [`:h terminal_emulator.txt`][terminal_emulator]
* [`:h vim-modes`][modes]
* [`:h :tnoremap`][tnoremap]

[:terminal]: https://neovim.io/doc/user/various.html#%3Aterminal
[termopen()]: https://neovim.io/doc/user/eval.html#termopen%28%29

[terminal_emulator]: https://neovim.io/doc/user/nvim_terminal_emulator.html#terminal_emulator.txt
[modes]: https://neovim.io/doc/user/intro.html#vim-modes
[tmap]: https://neovim.io/doc/user/map.html#%3Atmap
[inoremap]: https://neovim.io/doc/user/map.html#%3Ainoremap
[nnoremap]: https://neovim.io/doc/user/map.html#%3Annoremap
[tnoremap]: https://neovim.io/doc/user/map.html#%3Atnoremap
