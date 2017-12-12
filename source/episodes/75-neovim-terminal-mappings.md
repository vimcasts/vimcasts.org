---
:title: Creating mappings for :terminal
:date: 2017/12/12
:poster: /images/posters/neovim-terminal-mappings.png
:duration: 308
:number: 75
:tags: Neovim, Terminal Emulator
---

Neovim lets us create mappings using the meta key.
In this video, we'll set up some mappings to make it easier to exit from Terminal mode.
We'll also set up mappings using the meta key with h, j, k, and l to switch between split windows.

READMORE

### Terminal mode mappings and meta key bindings

You can use the [`:tnoremap`][tnoremap] command to create a mapping that applies only in Terminal mode.
This is much like how `inoremap` creates a mapping that apply only in Insert mode, and `vnoremap` creates a mapping that applies only in Visual mode.

In Neovim, you can create mappings that bind [meta keys][meta].
(That's not possible when running Vim in a terminal, although it is possible using GVim.)
You can create meta key mappings using either of these notations: `<M-...>` or `<A-...>`.

You may have to configure your terminal app to make it handle meta keys in a way that Neovim can understand.
In the video, I demonstrate how to make iTerm2 send the option key as `+Esc`, which makes it behave as a meta key.

In the following sections, we'll create Terminal mode mappings using meta key bindings.

### Getting out of Terminal mode

To get out of Terminal mode, we have to press *control-backslash-control-n*.
That's awkward!
Whether you're in Insert mode, Visual mode, or Commandline mode, the escape key usually gets you back into Normal mode.
I like to make the `<Esc>` key have the same affect in Terminal mode: returning you to Normal mode.

To get this behaviour, put this snippet of Vim script into your `vimrc` file:

```viml
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif
```

This creates a new problem though: you can no longer send an escape key to the program running inside the terminal buffer.

To avoid this problem, you can create another mapping that sends an escape key to the underlying program.
In the snippet above, I've offered two suggestions.

The first is `<M-[>`. If you're in the habit of pressing `<C-[>` instead of the `<Esc>` key (both have the exact same effect), then pressing `<M-[>` feels quite similar. In Terminal mode, `<M-[>` sends an escape key to the underlying program, while `<C-[>` will switch back to Normal mode.

As an alternative, I've also suggested using `<C-v><Esc>` to send an escape key to the underlying program (mnemonic: Verbatim escape).
I suggest this mapping because it feels idiomatic: for example, in Insert mode you can use `<C-v>{nondigit}` to enter a nondigit character literally. This allows you to insert a tab character by pressing `<C-v><Tab>`, even when the tab key has been configured to insert spaces.

### Switching windows

In Normal mode, you can change focus between split windows using `<C-w>{h,j,k,l}` (that's two keystrokes).
In Terminal mode, if you want to focus another split window, you first have to switch to Normal mode (by default: `<C-\><C-n>`, two keystrokes), then use the usual Normal mode command.
All those keystrokes add up, making it feel inconvenient to switch windows.

You could create a mapping for Terminal mode so that pressing `<M-{h,j,k,l}>` would move you to another window.
While you're at it, you may as well create similar mappings for the other modes too.
Try putting this in your `vimrc` file:

```viml
if has('nvim')
  " Terminal mode:
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
  " Insert mode:
  inoremap <M-h> <Esc><c-w>h
  inoremap <M-j> <Esc><c-w>j
  inoremap <M-k> <Esc><c-w>k
  inoremap <M-l> <Esc><c-w>l
  " Visual mode:
  vnoremap <M-h> <Esc><c-w>h
  vnoremap <M-j> <Esc><c-w>j
  vnoremap <M-k> <Esc><c-w>k
  vnoremap <M-l> <Esc><c-w>l
  " Normal mode:
  nnoremap <M-h> <c-w>h
  nnoremap <M-j> <c-w>j
  nnoremap <M-k> <c-w>k
  nnoremap <M-l> <c-w>l
endif
```

### Further reading

* [`:h meta`][meta]
* [`:h :tnoremap`][tnoremap]
* [`:h terminal-input`][input]
* [News: Neovim can now bind meta keys][tui]

[meta]: https://neovim.io/doc/user/intro.html#meta
[tnoremap]: https://neovim.io/doc/user/map.html#%3Atnoremap
[input]: https://neovim.io/doc/user/nvim_terminal_emulator.html#terminal-input
[tui]: https://neovim.io/news/2015/april/#terminal-ui-tui
[libtermkey]: http://www.leonerd.org.uk/code/libtermkey/
