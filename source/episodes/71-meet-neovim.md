---
:title: Meet Neovim
:date: 2017/10/24
:poster: /images/posters/meet-neovim.png
:duration: 323
:number: 71
:tags: Neovim
---

In this video, we'll see how to install and set up Neovim so that it reuses your existing Vim configuration files.
Most plugins should work in Neovim just like they do in Vim.

READMORE

The Neovim Wiki has comprehensive [instructions on how to install Neovim][install] on various platforms. On OS X, you can install Neovim with homebrew:

    brew install neovim

When I recorded this video, the Neovim homebrew formula was available via the Neovim tap. Back then, you had to run `brew install neovim/neovim/neovim`. Since then, the Neovim formula has been added to Homebrew core, which makes installation slightly simpler.

### Reusing Vim configuration

Vim's runtime files are typically kept in a `~/.vim` directory.
Neovim uses the [XDG base directory specification][xdg], which means that your configuration files are kept in a `~/.config/nvim` directory.
Whereas Vim usually looks for a configuration file at either `~/.vimrc` (or `~/.vim/vimrc`), Neovim looks for a file at `~/.config/nvim/init.vim`.

If you like, you can maintain a different configuration for Vim and Neovim.
Alternatively, you can set things up in such a way that both editors use the same configuration files.
The second approach allows you to try out Neovim with minimal disruption.

You can find advice on how to reuse your Vim configuration in Neovim by looking up [`:help nvim-from-vim`][nvim-from-vim]. First, create a config directory for Neovim:

    mkdir -p ~/.config/nvim

Then create a `~/.config/nvim/init.vim` file with the following contents:

```viml
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
```

This way, all runtime files and packages in `~/.vim` will be loaded by Neovim. 
Any customisations you make in your `~/.vimrc` will now apply to Neovim as well as Vim.

### Plugin compatibility

Neovim can run most Vim plugins just fine.
As a general rule, if a plugin has been around since before version 8 of Vim came out, then you can be confident that it will work fine in Neovim.

The one area where you have to be cautious is with any plugin that uses job control to perform work asynchronously.
Neovim came out with this feature first, way back in 2014.
Vim released a similar feature with version 8, but the job control APIs are different.
Some plugins offer async functionality whether you run them in Vim 8 or in
Neovim, but some plugins may only work in one or the other.
This problem doesn't affect that many plugins since the job control functionality is relatively new, but it is something to watch out for.

Neovim can run any plugin written in Vimscript.
But it also supports [remote plugins][remote], which can be written in any language.
These run in a separate process, using remote procedure calls (RPC) to communicate with the neovim process.
Remote plugins are a game changer for plugin authors.

On the wiki, there's a [list of plugins][nvim-plugins] that exploit Neovim's features, such as remote plugins and the built in terminal.
I expect to see this list growing over time.

### Further reading

* [Installing Neovim][install]
* [XDG Base Directory Specification][xdg]
* [`:help base-directories`][base-directories]
* [`:help nvim-from-vim`][nvim-from-vim]
* [`:help vim_diff`][vim_diff]
* [`:help remote_plugin`][remote]
* [List of plugins using Neovim-specific features][nvim-plugins]

[install]: https://github.com/neovim/neovim/wiki/Installing-Neovim
[xdg]: https://specifications.freedesktop.org/basedir-spec/latest/index.html
[base-directories]: https://neovim.io/doc/user/starting.html#xdg
[nvim-from-vim]: https://neovim.io/doc/user/nvim.html#nvim-from-vim
[vim_diff]: https://neovim.io/doc/user/vim_diff.html
[nvim-plugins]: https://github.com/neovim/neovim/wiki/Related-projects#plugins
[remote]: https://neovim.io/doc/user/remote_plugin.html
