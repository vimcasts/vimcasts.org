For the sake if this demo, I'm starting out with a fresh installation of Vim 8 and no plugins.

[launch vim, callout the version number on start page]

If we inspect the `runtimepath` we'll see that it includes the default directories for configuring Vim, but it does not reference any plugins.

    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after

We'll start by creating a directory where we can put our plugins:

    mkdir -p ~/.vim/pack/bundle/start

We have to create the `pack` and `start` directories, because they have special significance for Vim's packages feature.
The other directory can be named any way you like.
Here, we'll use `bundle` as the name of our package.

Now let's switch to the `start` directory.

    cd ~/.vim/pack/bundle/start

If we place a subdirectory here containing the source code for a Vim plugin, then Vim will automatically add that directory to our runtimepath.
Let's grab a couple of plugins from tpope.

    git clone git@github.com:tpope/vim-surround.git
    git clone git@github.com:tpope/vim-unimpaired.git

Let's launch Vim and inspect our runtimepath:

    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after,~/dotfiles/vim/pack/bundle/start/vim-surround,~/dotfiles/vim/pack/bundle/start/vim-unimpaired

now it references the paths of the two plugins that we just installed.

We can toggle line numbering using the `con` mapping (which is supplied by unimpaired).
And we can quickly swap between different types of parentheses using the mappings supplied by the surround plugin.

We can now use the features from these plugins, but there's one thing missing: documentation.
If we try to look up the help pages:

    :help unimpaired
    :help surround

we get nothing.

That's because we haven't generated the helptags for these plugins.
Here's what our `bundle` directory looks like at present:

    :!tree
    .
    ├── vim-surround
    │   ├── README.markdown
    │   ├── doc
    │   │   ├── surround.txt
    │   └── plugin
    │       └── surround.vim
    └── vim-unimpaired
        ├── README.markdown
        ├── doc
        │   └── unimpaired.txt
        └── plugin
            └── unimpaired.vim
    
    6 directories, 8 files

We can fix this by running the command:

    :helptags ALL

Our plugins now contain `tags` files in their `doc` directories:

    :!tree
    .
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
    
    6 directories, 8 files

And we can look up the documentation for the plugins:

    :help unimpaired
    :help surround

## Installing optional plugins

Our `bundle` package currently contains a `start` subdirectory.
Any plugins that we install here will be loaded when Vim starts up.
We can add another subdirectory called `opt`, for optional plugins.

    mkdir -p ~/.vim/pack/bundle/opt

This is handy if you have plugins that you use only occasionally.

Let's try installing another one of tpope's plugins: scriptease.
This plugin adds features that are useful when working with Vimscript, which you may not need to use every day.

    cd ../opt
    git clone git@github.com:tpope/vim-scriptease.git

Let's restart Vim and inspect our runtimepath:

    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after,~/dotfiles/vim/pack/bundle/start/vim-surround,~/dotfiles/vim/pack/bundle/start/vim-unimpaired

It includes the plugins from our `start` subdirectory, but not `scriptease`.
And if we try using any of the features from that plugin, we'll find them unavailable:

    :Scriptnames
    E492: Not an editor command: Scriptnames

We can activate this optional plugin using the `:packadd` command:

    :packadd vim-scriptease

Now `scriptease` appears in our runtimepath:

    :set rtp?
    runtimepath=~/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,~/.vim/after,~/dotfiles/vim/pack/bundle/start/vim-surround,~/dotfiles/vim/pack/bundle/opt/vim-scriptease,~/dotfiles/vim/pack/bundle/start/vim-unimpaired

And its features are available to us:

    :Scriptnames

## Migrating from pathogen to packages

Before version 8 came out, Vim's built-in support for installing plugins was lousy.
Tim Pope created the `pathogen` plugin to ease the pain of installing plugins.
The packages feature in Vim 8 basically implements the same features as `pathogen`, with the addition of support for optional plugins.
If you're currently using `pathogen`, I would recommend upgrading to Vim 8 and uninstalling `pathogen`.

If you're currently using a package manager such as `vim-plug` or `Vundle`, check out the next video on `minpac` for a modern alternative.
