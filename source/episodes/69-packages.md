---
:title: Installing plugins using packages
:date: 2017/10/04
:poster: /images/posters/packages.png
:duration: 279
:number: 69
:tags: plugins
---

Packages are a new feature in version 8 of Vim.
In this video, we'll see how we can use packages to easily install Vim plugins.
The process will be familiar if you've used `pathogen`.

READMORE

It's easy to confuse the terms package and plugin, so let's start by defining the terminology:
A *plugin* is a directory containing one or more scripts.
A *package* is a directory containing one or more plugins.

If that makes sense, you can skip the next two sections. Otherwise, read on...

### What's a Plugin?

A plugin is a directory containing one or more scripts (usually with documentation).
The purpose of a plugin is to add new functionality to Vim, or to modify Vim's existing functionality.
A `demo-plugin` containing one script and an accompanying documentation file might look like this:

```
demo-plugin
├── doc
│   └── demo.txt
└── plugin
    └── demo.vim
```

To install this plugin, you would add the top-level `demo-plugin` directory to Vim's [runtimepath][rtp]. You could manipulate the runtimepath by hand:

```viml
set runtimepath+=~/.vim/arbitrary/demo-plugin
```

Vim has supported plugins since version 6, but until recently there was no convenient way of managing the `runtimepath`.
You had to do it by hand, or you had to install a plugin to automate the runtimepath management.
With version 8, Vim released the packages feature to fill this gap.

### What's a Package?

A package is a directory that contains one or more plugins.
When you organise your plugins in a package, Vim can automatically add those plugins to your `runtimepath` on startup.

By convention, you create packages within a `.vim/pack` directory.
Your package should contain a subdirectory called `start`, which is where you install the plugins that you want to load when Vim starts up.

You can create as many packages as you like. For example, you might create one package called `bundle` where you install plugins written by other people. Then you might create another package called `myplugins` where you keep the plugins that you maintain by yourself.

### Further reading

* [`:h 'runtimepath'`][rtp]
* [`:h packages`][packages]
* [`:h :packadd`][packadd]
* [`:h packload-two-steps`][packload-two-steps]
* [`:h :helptags`][helptags]

[packages]: https://neovim.io/doc/user/repeat.html#packages
[packadd]: https://neovim.io/doc/user/repeat.html#%3Apackadd
[helptags]: https://neovim.io/doc/user/helphelp.html#%3Ahelptags
[packload-two-steps]: https://neovim.io/doc/user/repeat.html#packload-two-steps
[rtp]: https://neovim.io/doc/user/options.html#%27rtp%27
