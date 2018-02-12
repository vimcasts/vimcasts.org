### Pasting into the Terminal

Here we've got a text buffer containing a list of commands.
Let's say that we want to execute these commands one by one in our Terminal emulator.

We can use the `yy` command to yank a line of text.
And if we switch over to our terminal emulator, we can use the Normal mode `p` command to paste the text on the command line.
We can then execute the command line by switching to Terminal mode and pressing the enter key.

Notice that when we use the `p` command in a regular buffer, the text is pasted at the current cursor position.
In a terminal buffer, it doesn't matter where Vim's cursor is positioned.
The `p` command always puts the text on the current command line.
This makes sense when you recall that the only part of a terminal buffer that can be modified is the current command line.

Now watch this: I'm going to switch to Terminal mode and enter some text, then I'll move my cursor to the start of the command line.
Then I'll switch back to Normal mode and yank another command from my text buffer.
This time when I use the `p` command, the text is inserted at the start of the command line.
Where the text appears is determined by the position of the *Terminal cursor*, which is distinct from Vim's Normal mode cursor.

I'm currently using the `solarized8` colorscheme, which has full support for Neovim's terminal emulator.
If I switch to the default colorscheme, you'll see that the *Terminal cursor* is no longer visible.
It's still in the same place, but this colorscheme doesn't have the appropriate highlight groups configured to make it visible outside of Terminal mode.

NeoVim defines two syntax groups that let us style the terminal cursor when the terminal is active or inactive.

    :help TermCursor

I'll just paste this into my command line to style the `TermCursorNC` highlight group:

    hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

That makes the terminal cursor visible again.
Without this, it's hard to tell where the text is going to appear when we use the `p` command.
If the colorscheme you're using doesn't already define highlight groups for the `TermCursor`, then I'd encourage you to add them to your colorscheme.

Here's how it looks in solarized8.
It just means adding a couple of lines of code.

### Pasting a register in Terminal mode

In Insert mode, we can paste the contents of a register by pressing *control-r* followed by the address of the register.

    :h i_ctrl-r

I'll demonstrate here by yanking some text.
Switching to insert mode.
Then pressing *control-r* followed by zero, to specify the yank register.

It would be handy if we could also do this in Terminal mode.
Let's try it and see what happens...

Our command line now shows the prompt: `(reverse-i-search)`.
That's because in my bash shell, the *control-r* chord is mapped to do an incremental history search.
Remember: in terminal mode, all keys and chords are forwarded to the underlying program.
So it looks like we can't use control-r to paste a register in Terminal mode the way that we can in Insert mode.

We don't get this functionality out of the box, but we can create a mapping that gives us this behavior.

I like the incremental search feature in bash and I've already got muscle memory for using it, so I'm not going to clobber the control-r mapping.
Instead, we're using *alt-r* to trigger our customisation.

    :tnoremap <expr> <A-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'

The right-hand side of this mapping is tricky to parse!
We're building a string will be evaluated as an expression.
If we switch the function calls for a `{register}` placeholder, the meaning should become clearer.

    <C-\><C-n>"[reg]pi

We're exiting terminal mode, then pasting the specified register, then switching back into Terminal mode.

Let's write and reload our vimrc:

    :source %

And let's see this new mapping in action...
I'll yank some text from this regular buffer.
Then switch to Terminal mode...
When I press *alt-r*, Neovim waits for me to specify a register, in this case I'll use *zero* to specify the yank register.
There we have it: we've pasted the contents of a register without having to leave Terminal mode.
