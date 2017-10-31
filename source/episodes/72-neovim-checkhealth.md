---
:title: CheckHealth in Neovim
:date: 2017/10/31
:poster: /images/posters/neovim-checkhealth.png
:duration: 319
:number: 72
:tags: Neovim
---

Neovim's `:checkhealth` command can diagnose problems with your configuration.
In this video, we'll run this command and follow its suggestions to enable features such as python integration and ruby integration.

READMORE

The `:checkhealth` command runs a series of diagnostic tests to check the health of your Neovim installation.
If it uncovers any problems, it usually offers suggestions on how to fix them, or where to go to learn more.

### Optional features in Vim and Neovim

Vim and Neovim have different ways of enabling optional features.
Simply put: Vim can enable optional features at *compile time*, whereas Neovim can enable optional features at *runtime*.

When you compile Vim, you can use the `--with-features` flag to specify a `tiny`, `small`, `normal`, `big`, or `huge` feature set.
Look up [`:help +feature-list`][feature-list] to find out which features are included in each type of build.

Neovim always builds using the equivalent of a `huge` feature set.
Instead, Neovim uses *providers*, which make it possible to dynamically enable functionality when the necessary tools are available in the environment.
Currently Neovim ships with providers for [clipboard support][clipboard], [python integration][python], and [ruby integration][ruby].

For example, take clipboard support on OS X.
The version of Vim that ships with OS X was compiled without clipboard support.
If you want Vim with clipboard support on OS X, then you either have to recompile or reinstall Vim.
With Neovim, you simply have to make sure that `pbcopy` and `pbpaste` are available and the clipboard feature works automatically.

### :CheckHealth or :checkhealth

The `:CheckHealth` command has been available since version 0.1.5 of Neovim.
With Neovim version 0.2.1 and newer, you can use `:checkhealth` (as well as `:CheckHealth`). This screencast was recorded using version 0.1.7 of Neovim, so you'll see me using `:CheckHealth`, because it was the only option at the time.

Remember: user-defined commands always have to begin with a capital letter, while commands that start with a lowercase letter are always built-in commands.

### Further reading

* [`:help :checkhealth`](https://neovim.io/doc/user/pi_health.html#%3Acheckhealth)
* [`:help provider-clipboard`][clipboard]
* [`:help g:clipboard`][g:clipboard]
* [`:help provider-python`][python]
* [`:help provider-ruby`][ruby]

[clipboard]: https://neovim.io/doc/user/provider.html#provider-clipboard
[g:clipboard]: https://neovim.io/doc/user/provider.html#g%3Aclipboard
[python]: https://neovim.io/doc/user/provider.html#provider-python
[ruby]: https://neovim.io/doc/user/provider.html#provider-ruby
[feature-list]: http://vimhelp.appspot.com/various.txt.html#%2Bfeature-list
