## Installing minpac

For the sake if this demo, we'll start out with a fresh installation of Vim 8 and no plugins.

We'll start by creating a new package for minpac, naming it after the plugin itself:

    mkdir -p ~/.vim/pack/minpac/opt

The `minpac` plugin should be installed as an optional plugin, so we'll change to the `opt` subdirectory and clone it there:

    cd ~/.vim/pack/minpac/opt
    git clone https://github.com/k-takata/minpac.git

Let's open up our `vimrc` file...
and we'll add two lines:

    packadd minpac
    call minpac#init()

to load the plugin then initialize it.

Now let's reload our `vimrc` file and inspect our runtimepath:

    :source ~/.vimrc
    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after,~/dotfiles/vim/pack/minpac/opt/minpac

Minpac is now installed.

## Adding plugins

We can add plugins by calling the `minpac#add()` function.
This takes as an argument a string representing the author's github username and the name of the plugin itself.
Let's add the `surround`, `unimpaired`, and `scriptease` plugins:

    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('tpope/vim-scriptease')

This function takes an optional second argument, which can be a dictionary of config options.
By default, `minpac` installs plugins to the `start` directory, but we could override this by specifying `'type': 'opt'`.
We'll use this method to register the `scriptease` plugin:

    call minpac#add('tpope/vim-scriptease', {'type':'opt'})

And while we're at it let's register `minpac` as well, so that our package manager can update itself:

    call minpac#add('k-takata/minpac', {'type':'opt'})

We can install these plugins by reloading our `vimrc` then calling the `minpac#update()` function:

    :source ~/.vimrc
    :call minpac#update()

For each plugin that's been registered, `minpac` will either install it fresh, or fetch the latest version from github.
As each plugin is processed `minpac` logs a message.
In this case the messages went by too quickly to see, but we can view the logs by running the `:messages` command:

    :messages
    Installing vim-scriptease
    Installing vim-surround
    Installing vim-unimpaired
    Finished

Now let's look inside our `minpac` package:

    :!tree ~/.vim/pack/minpac
    /Users/drew/.vim/pack/minpac/
    ├── opt
    │   └── minpac
    │       ├── README.md
    │       ├── autoload
    │       │   └── minpac
    │       │       ├── LICENSE-async-vim.txt
    │       │       ├── impl.vim
    │       │       └── job.vim
    │       ├── doc
    │       │   └── minpac.txt
    │       ├── plugin
    │       │   └── minpac.vim
    │       └── tools
    │           └── pull-async-vim.sh
    └── start
        ├── vim-surround
        │   ├── README.markdown
        │   ├── doc
        │   │   ├── surround.txt
        │   │   └── tags
        │   └── plugin
        │       └── surround.vim
        └── vim-unimpaired
            ├── README.markdown
            ├── doc
            │   ├── tags
            │   └── unimpaired.txt
            └── plugin
                └── unimpaired.vim

    14 directories, 15 files

The plugins have been added to our package, but we can't use them yet.
To make Vim load these plugins, we'll have to restart.

Now if we inspect our runtimepath:

    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after,~/dotfiles/vim/pack/bundle/start/vim-surround,~/dotfiles/vim/pack/bundle/start/vim-unimpaired

it includes the plugins that we installed to the `start` directory, as well as `minpac` itself.

We can toggle line numbering using the `con` mapping (which is supplied by unimpaired).
And we can quickly swap between different types of parentheses using the mappings supplied by the surround plugin.

We can also consult the documentation for our newly installed plugins:

    :help surround

because `minpac` automatically generates helptags each time it updates a plugin.

## Removing plugins

`minpac` also makes it easy to uninstall plugins using the `minpac#clean()` function.
Let's remove the `scriptease` plugin.
Then we'll save and reload our vimrc and call the `clean()` function:

    :source %
    :call minpac#clean()
    /Users/demo/.vim/pack/minpac/opt/vim-scriptease
    Removing the above directory. [y/N]?

We get a prompt asking if we're sure we want to remove the directory.
I'll answer `y` for yes.
And that's all there is to it.

## Convenience commands

As the name suggests, `minpac` is a minimal package manager.
It [doesn't define any commands][usage] it only defines functions, which we can execute via the `:call` command.
We can create our own commands for ease of use.
We'll create shorthand commands for the update and clean tasks.


    " minpac commands:
    command! PackUpdate call minpac#update()
    command! PackClean call minpac#clean()

If I save my vimrc and reload it, I can now test these commands:

    :w
    :source %
    :PackUpdate
    All plugins are up to date
    :PackClean
    Already clean

[usage]: https://github.com/k-takata/minpac#usage

## Migrating from other plugin managers

Plugin managers such as `Vundle` and `vim-plug` pre-date the native packages feature that came out with version 8 of Vim.
These plugins had to invent their own solutions for managing the runtimepath, whereas `minpac` simply builds on top of the packages feature and gets the runtimepath management for free.

Minpac can install and update plugins in parallel.
This is made possible by Vim's job control feature, which is also new in version 8.

    :help channel

By building on top of native functionality, `minpac` is able to provide the basic features of a package manager with a very minimal codebase.
