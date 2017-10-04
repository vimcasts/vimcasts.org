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
You had to do it by hand, or you had to install a plugin such as [pathogen][] to automate the runtimepath management.
With version 8, Vim released the packages feature to fill this gap.

### What's a Package?

A package is a directory that contains one or more plugins.
When you organise your plugins in a package, Vim can automatically add those plugins to your `runtimepath` on startup.

By convention, you create packages within a `.vim/pack` directory.
Your package should contain a subdirectory called `start`, which is where you install the plugins that you want to load when Vim starts up.

You can create as many packages as you like. For example, you might create one package called `bundle` where you install plugins written by other people. Then you might create another package called `myplugins` where you keep the plugins that you maintain by yourself.

### Creating a 'bundle' package

Create a package called `bundle` where you'll install your plugins:

```
mkdir -p ~/.vim/pack/bundle/start
mkdir -p ~/.vim/pack/bundle/opt
```

Any plugins that you install in the `start` directory will be added to your `runtimepath` when Vim starts up.

The `opt` directory is for optional plugins. You can add these to your runtime path when you need them by using the `:packadd` command.

### Installing plugins to the 'bundle' package

Let's install some tpope plugins: [surround][], [unimpaired][], and [scriptease][].
Change to the `bundle/start` directory, and clone the surround and unimpaired repositories there:

```
cd ~/.vim/pack/bundle/start
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/tpope/vim-unimpaired.git
```

If you start a fresh instance of Vim, these plugins will be available for you to use right away.
(If you're already running an instance of Vim, you'll have to restart to use these plugins.)

Next, clone the scriptease plugin to the `bundle/opt` directory:

```
cd ~/.vim/pack/bundle/opt
git clone https://github.com/tpope/vim-scriptease.git
```

If you start a fresh instance of Vim, you won't be able to use the scriptease plugin right away. First, you have to activate it by running:

```
:packadd vim-scriptease
```

That adds the plugin to your `runtimepath` and makes the features of scriptease available to you. (To see for yourself, try running `:Scriptnames`.)

### Indexing plugin documentation

Most plugins include documentation, which you can view using the same `:help` command that you use for Vim's built-in documentation.
Before you can look up the documentation for a newly installed plugin, you have to index its documentation.
You can do so by running:

```
:helptags ~/.vim/pack
```

You only need to do this one time after installing (or updating) a plugin.

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
[pathogen]: https://github.com/tpope/vim-pathogen
[surround]: https://github.com/tpope/vim-surround
[unimpaired]: https://github.com/tpope/vim-unimpaired
[scriptease]: https://github.com/tpope/vim-scriptease
