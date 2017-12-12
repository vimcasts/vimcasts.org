In Neovim, the terminal UI has been refactored to use libtermkey under the hood.
As a result, it's now possible to create mappings using the meta key, which isn't possible when running Vim in the terminal.
This opens up new space for creating chords, and meta key mappings are unlikely to conflict with your terminal app.

https://neovim.io/news/2015/april/#terminal-ui-tui

If you want to use meta key chords in iterm2, you may have to specify how the option keys work.
Open iterm2 preferences, go to "profiles", then select the "Keys" tab.
Here, you can configure the behaviour of your option keys.
I've configured my left option key to act as "+Esc", and I've left my right option key to behave as normal.

If you're using a different terminal app, you may have to follow similar steps to get the same behaviour.

### Getting out of Terminal mode

To get out of Terminal mode, we have to press *control-backslash-control-n*.
That's awkward!
Whether you're in Insert mode, Visual mode, or Commandline mode, the escape key usually gets you back into Normal mode.
Let's set up a mapping so that pressing the escape key has the same effect:

    if has('nvim')
      tnoremap <Esc> <C-\><C-n>
    endif

Let's save and reload...

Although I talk about pressing escape, I tend to prefer using "control-open-bracket", which has the same effect.

    :h i_ctrl-[

Vim's documentation suggests that you train yourself to use this chord, because on many keyboards it's easier to reach than the escape key.
Having created this mapping, we can now use "control-open-bracket" (or the escape key) to exit Terminal mode.

Our new mapping creates a new problem for us: we can no longer send the escape key to the underlying program in our terminal buffer.
Let's set up another mapping to work around this:

    if has('nvim')
      tnoremap <A-[> <Esc>
    endif

I've chosen to use "alt-open-bracket" here, because (on my keyboard at least), it feels similar to pressing "control-open-bracket", so I've found it easy to train my fingers to do this.

Now if we reload the vimrc and start up terminal mode, we can try these out.

Using "alt-open-bracket" sends an escape key to the terminal.
And using "control-open-bracket" switches us back to Normal mode.
That feels much more user-friendly now.

### Window switching

Here, we have Neovim open with two split windows: one containing a regular buffer, and the other containing a terminal buffer.

Let's focus the terminal buffer and switch to Terminal mode.
We can now interact with the terminal emulator.
If we want to switch to the other split window, we first have to leave terminal mode, then we can activate the other window by pressing *control-w-h*.
That's four keystrokes!

Let's make this workflow more convenient by setting up some mappings.
We'll use the *alt* key with h, j, k, and l, to create window switching chords for Terminal mode:

    if has('nvim')
      tnoremap <a-h> <c-\><c-n><c-w>h
      tnoremap <a-j> <c-\><c-n><c-w>j
      tnoremap <a-k> <c-\><c-n><c-w>k
      tnoremap <a-l> <c-\><c-n><c-w>l
    endif

Let's break down how this mapping works:

* `tnoremap` - in Terminal mode,
* `<a-h`> if I press *alt-h*
* interpret as though I pressed *control-backslash-control-N* (which switches to Normal mode) followed by *control-w-h* (which moves the focus to the left)

While we're at it, let's set up equivalent mappings for Normal mode:

    nnoremap <a-h> <c-w>h
    nnoremap <a-j> <c-w>j
    nnoremap <a-k> <c-w>k
    nnoremap <a-l> <c-w>l

Let's source our vimrc so that we can try out our new mappings:

    :source %

And we'll add a couple more split windows so we can move in all four directions...
We can now switch windows using *alt* with h, j, l, or k, whether we're in Normal mode or Terminal mode.
