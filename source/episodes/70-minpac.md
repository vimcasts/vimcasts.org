---
:title: Meet minpac
:date: 2017/10/13
:poster: /images/posters/minpac.png
:duration: 323
:number: 70
:tags: plugins
---

Minpac is a minimal package manager for Vim 8.
It makes it easy to add plugins, keep them up to date, and remove them.
In this video, we'll see how it works.

READMORE

### Installing minpac

Minpac should be installed as an optional plugin, in a package called `minpac`:

    $ mkdir -p ~/.vim/pack/minpac/opt
    $ cd ~/.vim/pack/minpac/opt
    $ git clone https://github.com/k-takata/minpac.git

Add these lines to your `vimrc` file:

```viml
packadd minpac
call minpac#init()
```

That's it. Now you can use minpac to install other plugins.

### Registering plugins

You can register plugins with minpac by calling the `minpac#add()` function. The first argument is a string representing the `author/repo-name` on github. The optional second argument can be a dictionary of options.

For example, add these lines to your `vimrc`:

```viml
call minpac#add('tpope/vim-surround')
call minpac#add('k-takata/minpac', {'type':'opt'})
```

That registers Tim Pope's surround plugin, as well as minpac itself. By default, minpac installs plugins to the `pack/minpac/start` directory. By specifying `{'type': 'opt'}`, you can make minpac install a plugin to the `pack/minpac/opt` directory.

Calling `minpac#add()` tells minpac that you intend to install the plugin. To actually install the plugin, you have to call the `minpac#update()` function. For each plugin that you've registered, minpac will fetch the latest version from github.

First, source your `vimrc` file, then call the function:

    :source $MYVIMRC
    :call minpac#update()

You won't see much output while the command runs.
Minpac uses Vim's job control API to fetch the plugins in the background.
When finished, it prints a summary showing how many plugins were installed or updated.

### Removing plugins

To uninstall a plugin, remove the line of code in your `vimrc` where you registered the plugin, then source your `vimrc` and call the `minpac#clean()` function. 

    :source $MYVIMRC
    :call minpac#clean()

Minpac will loop through all of the plugins in the `pack/minpac/{start,opt}` directories, marking for deletion any plugins that are not registered with minpac.
You will see a prompt naming each plugin to be deleted, which gives you the chance to opt out if you change your mind.

### Convenience commands

As the name suggests, `minpac` is a minimal package manager.
It doesn't define any commands it only defines functions, which you can execute via the `:call` command.
For ease of use, you can create your own commands:

    command! PackUpdate call minpac#update()
    command! PackClean call minpac#clean()

Instead of `:call minpac#update()` you can now run `:PackUpdate` to do the same thing.

### How I use minpac

I like to specify my plugins in a separate file called `packages.vim`, which starts like this:

```viml
command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if !exists('*minpac#init')
  finish
endif

call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/surround')
" ...
```

My `vimrc` file contains this line, which loads the `packages.vim` file:

```viml
source ~/.vim/packages.vim
```

This is a variation of the method described in the documentation for [loading minpac on demand][ondemand].
With this technique, minpac doesn't load when Vim starts up.
It only loads when you call either `:PackUpdate` or `:PackClean`.
Pretty cool!

### Further reading

Here's an implementation detail which I find interesting: minpac uses Prabir Shrestha's [async.vim][async] to run the update/clean jobs.
The job control API differs between Neovim and Vim 8, which is a pain if you want to write plugins that work in both.
The async.vim plugin normalizes these APIs, taking out the hassle.

* [minpac][]
* [async.vim][async]

[minpac]: https://github.com/k-takata/minpac
[async]: https://github.com/prabirshrestha/async.vim
[ondemand]: https://github.com/k-takata/minpac#load-minpac-on-demand
