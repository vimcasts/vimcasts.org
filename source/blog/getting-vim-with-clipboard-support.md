--- 
:title: Getting Vim with `+clipboard` support
:date: 2013/11/13
:tags: registers, copy-and-paste
---

Many systems ship with a version of Vim that was compiled with the `-clipboard` feature disabled, which is a damned nuisance! Being able to [access the system clipboard from Vim][58] is an essential feature. Let's look at a few ways of getting the `+clipboard` feature on OS X and Ubuntu.

[58]: http://vimcasts.org/e/58


READMORE

### On OS X

On OS X Mavericks, Apple ships Vim version 7.3 with `-clipboard`. Here's the gist from running [`/usr/bin/vim --version` on Mavericks][10.9] (and [the same on Mountain Lion][10.8]). Shame on you Apple!

If you [use Homebrew][brew.sh], you can get Vim with `+clipboard` by running:

    brew install vim

Here's a gist from running [`/usr/local/bin/vim --version`][brew].

Alternatively, you could [download MacVim][mvim]. Look inside `/Applications/MacVim.app/Contents/MacOS`, and you'll see that the app provides two binaries: `MacVim`, which launches the GUI, and `Vim`, which runs in the Terminal with the same feature set. Both versions include the `+clipboard` feature. Here's a gist from running [`/Applications/MacVim.app/Contents/MacOS/Vim --version`][macvim].

### On Linux

On desktop Linux systems the clipboard is handled by the X window system. Most systems that use X11 will ship a version of Vim with the `+clipboard` feature. If your desktop Linux distribution ships with Vim without the `+clipboard` feature, you should be able to install a Vim package that provides this feature, e.g. each of these packages for Ubuntu provides Vim with `+clipboard`: [vim-gnome][], [vim-athena][], and [vim-gtx][].

Robin Skahjem-Eriksen wrote to me with a tip: you can run GVim inside the terminal by launching it with the `gvim -v` command. That could be handy if your distribution ship `vim` with `-clipboard`, but also ships `gvim` with `+clipboard`.

When Linux runs on a server it doesn't usually include X11. In this environment, it makes sense for Vim to be built with the `-clipboard` feature disabled. Some Vim packages are intended for systems without X11, such as the [`vim-nox`][vim-nox] package. It's possible to install packages on a Linux server that would add the `+clipboard` feature for Vim, but doing so would also install X11 and all its dependencies. That's probably not a good idea.

### Can we fix this?

Being able to [access the system clipboard from Vim][58] is essential. It's a nuisance that some desktop systems ship Vim without the `+clipboard` feature! I'd like to see that change. Please make the information in this article obsolete by campaigning to have `+clipboard` enabled by default on your system.

*Update: I've revised this article, because my understanding of Linux was terribly flawed. You can find the [original draft here][original]. Thanks to Will Gray for his patient explanations.*

[10.8]: https://gist.github.com/nelstrom/7435281
[10.9]: https://gist.github.com/nelstrom/7435463
[brew]: https://gist.github.com/nelstrom/7435520
[macvim]: https://gist.github.com/nelstrom/7435538
[brew.sh]: http://brew.sh/
[mvim]: https://code.google.com/p/macvim/downloads/list

[vim-nox]: https://gist.github.com/nelstrom/7436756
[58]: http://vimcasts.org/e/58
[original]: https://gist.github.com/nelstrom/7475980
[vim-gnome]: https://gist.github.com/nelstrom/7436451
[vim-athena]: https://gist.github.com/nelstrom/7436569
[vim-gtx]: https://gist.github.com/nelstrom/7436647
