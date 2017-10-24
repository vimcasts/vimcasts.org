## Installing Neovim

The Neovim wiki page has installation instructions for various unix platforms, as well as showing how to build from source.

I'm running mac os ten, so I'll follow the advice on how to install neovim using homebrew.

    brew install neovim/neovim/neovim

This command fetches the latest stable release, which is currently 0.1.7.
If you want to get all of the latest features and fixes, you might prefer to follow HEAD.
The Neovim wiki documents any breaking changes that you may need to be aware of.
I usually run the latest release and rarely have any problems, but for this video we'll stick with the stable release.

Once Neovim is installed, we can launch it with the `nvim` command.

## Migrating from Vim

Neovim works fine but it doesn't load any of our vim configuration files.
At a glance, you can see that `vim` is using my chosen colorscheme: `solarized8`, whereas `nvim` is using a default colorscheme.
Let's set things up so that Neovim uses our existing Vim configuration.

Vim looks in the user's home directory for a `.vim` directory which may contain runtime files.
And the `.vimrc` file is also typically kept in the user's home directory.
Neovim doesn't follow the same conventions here as Vim.
Instead, it conforms to the [XDG Base Directory Specification](https://neovim.io/doc/user/starting.html#base-directories).

    :help base-directories

That means we should keep all of our Neovim configuration in a `.config/nvim` directory.
And instead of looking for a `.vimrc` file in our home directory, Neovim looks within its config directory for a file called `init.vim`.

We can make Vim and Neovim use the same configuration files by setting up a minimal `init.vim` file.

We'll create the `~/.config/nvim` directory.
Then we'll create an `init.vim` file inside the new directory

    mkdir -p ~/.config/nvim
    nvim ~/.config/nvim/init.vim

Here', we're going to add the `~/.vim` directory to Neovim's runtimepath, and the `after` subdirectory too.
We'll also add the `~/.vim` directory as a `packpath`, so that any plugins loaded by the packages feature are also available to Neovim.
And finally, we'll source our `.vimrc` file.

    set runtimepath+=~/.vim,~/.vim/after
    set packpath+=~/.vim
    source ~/.vimrc

Now when we launch `nvim`, we can see right away that it's loaded the `solarized8_light` colorscheme.
Both Vim and Neovim are now loading the same `vimrc` and the same set of runtimefiles.

## Differences between Vim and Neovim

Neovim has removed a lot of cruft from Vim.
Some features have been removed, and some of the default settings have been changed.
And Neovim has added cool new features, some of which we'll explore in other videos.
The help page on [vim-differences](https://neovim.io/doc/user/vim_diff.html#vim-differences) documents these changes in detail.
It's worth reading in your own time.

## Plugins generally work fine

Neovim can run most Vim plugins just fine.
For example, I've got the surround.vim plugin installed.
The mappings work just the same in Neovim as they do in Vim.
As a general rule, if a plugin has been around since before version 8 of Vim came out, then you can be confident that it will work fine in Neovim.

The one area where you have to be cautious is with any plugin that uses job control to perform work asynchronously.
Neovim came out with this feature first, way back in 2014.
Vim released a similar feature with version 8, but the job control APIs are different.
Some plugins offer async functionality whether you run them in Vim 8 or in
Neovim, but some plugins may only work in one or the other.
Since the job control functionality is relatively new, this problem doesn't affect that many plugins, but it is something to watch out for.
This problem doesn't affect that many plugins since the job control functionality is relatively new, but it is something to watch out for.

Neovim can run any plugin written in Vimscript.
But it also supports *remote plugins*, which can be written in any language.
These run in a separate process, using remote procedure calls (RPC) to communicate with the neovim process.
Remote plugins are a game changer for plugin authors.

On the wiki, there's a [list of plugins][nvim-plugins] that exploit Neovim's features, such as remote plugins and the built in terminal.
I expect to see this list growing over time.

[nvim-plugins]: https://github.com/neovim/neovim/wiki/Related-projects#plugins
[install]: https://github.com/neovim/neovim/wiki/Installing-Neovim
[diff]: https://neovim.io/doc/user/vim_diff.html#vim-differences
[migrate]: https://neovim.io/doc/user/nvim.html#nvim-from-vim

