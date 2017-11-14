---
:title: Live substitution and yank highlighting
:date: 2017/11/14
:poster: /images/posters/neovim-eyecandy.png
:duration: 348
:number: 73
:tags: Neovim, Substitution, Copy and Paste, plugins
---

This video covers a couple of small but delightful Neovim features.
You'll see how to make Neovim show a live preview of how the substitute command will change our document.
And you'll find out how to make the yank operation highlight the range of text that it copied.

READMORE

### Live substitution

Vim's `:substitute` command only modifies the document when you execute the command, by pressing `<Enter>`.
In Neovim, you can make the `:substitute` command change the document *live* by setting the [`'inccommand'`][inccommand] option:

    :set inccommand=nosplit

Now, you'll see the document updating in real-time as you type out your substitute command.
If you press the `<Esc>` key, you can abort the substitute command and your document will instantly revert to how it looked before you started typing the command.
If you press the `<Enter>` key, your substitute command will apply and the changes to the document will stick.

Currently, the `'inccommand'` option only influences the behaviour of the substitute command.
In future, it may become possible to get live feedback on other commands, such as changing visual block mode, `:global` and `:normal` commands.

### Yank highlighting

Vim doesn't show any visual feedback when you use the yank command.
The [vim-highlightedyank][hly] plugin changes this, by applying a temporary highlight to the region of text that was yanked.

The highlightedyank plugin works both in Neovim and in Vim.
If you want to use the plugin in Vim, you have to remap the `y` command.
In Neovim, the plugin makes use of the [`TextYankPost`][TextYankPost] autocommand, which means that you don't need to remap the `y` command.

At first, I didn't think I needed to use the highlightedyank plugin.
I was accustomed to the behaviour of the yank command, and I didn't feel as though I needed any visual feedback to help me understand how the command worked.
Even so, I installed the highlightedyank plugin out of curiosity.
I was surprised to find how much I enjoyed that extra visual feedback.
I'm a convert!

### Further reading

* [`:help 'inccommand'`][inccommand]
* [`:help TextYankPost`][TextYankPost]
* [vim-highlightedyank][hly]

[inccommand]: https://neovim.io/doc/user/options.html#%27inccommand%27
[hly]: https://github.com/machakann/vim-highlightedyank
[TextYankPost]: https://neovim.io/doc/user/autocmd.html#TextYankPost
