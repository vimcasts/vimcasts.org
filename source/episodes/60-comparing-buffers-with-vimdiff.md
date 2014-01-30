--- 
:title: Comparing buffers with vimdiff
:date: 2014/01/15
:poster: /images/posters/vimdiff-buffers.png
:flattr_id: ""
:duration: 256
:number: 60
:ogg: 
  :url: http://media.vimcasts.org/videos/60/vimdiff.ogv
  :size: 9620942
:quicktime: 
  :url: http://media.vimcasts.org/videos/60/vimdiff.m4v
  :size: 13194774
:tags: vimdiff
---

Vim's diff mode allows us to easily compare the contents of two (or more) buffers. We can start Vim in diff mode using the `vimdiff` command, or if Vim is already running we can switch to diff mode using the `:diffthis` command. The beauty of the `:diffthis` command is that it works with unnamed buffers, whereas `vimdiff` can only work with files.

READMORE


### Using vimdiff to compare two files

We can call `vimdiff` from the command line giving it two or more filenames. vimdiff launches Vim, creates a window for each specified file, and highlights the differences between them.

In the video demonstration, one of the files that I wanted to compare was on my local filesystem, while the other file was in a textarea on a webpage. Before I could use `vimdiff`, I had to copy the text from that textarea into a local file. I did so using my system clipboard, then running the command:

    pbpaste > 45-shownotes-latest.md

The [`pbpaste`][pbpaste] command is specific to os x, but similar commands are available on other systems.

We can now compare the two drafts by running:

    vimdiff 45-shownotes-draft.md 45-shownotes-latest.md

I'm not keen on this workflow for a couple of reasons. I have no further use for the temporary file, so I'd have to clean up afterwards by removing it. Also, I usually have an instance of Vim open already, and I'd prefer a workflow that didn't require me to open a fresh instance of Vim.

### Using `:diffthis` to compare two buffers

The [`:diffthis`][diffthis] command allows us to compare two (or more) buffers that are open in an existing Vim session. If we have two split windows containing buffers that we want to compare, then we can diff them by running:

    :windo diffthis

We can turn diff mode off just as easily, by running:

    :windo diffoff

The nice thing about this technique is that we can use an unnamed buffer. There's no need to write the text to a temporary file. In the video demonstration, the buffer on the left corresponds to a file on my local filesystem, while the buffer on the right has no associated file. This technique would work just as well if neither buffer had been saved to disk, which makes it pretty flexible.

### Getting around in diff mode

In diff mode, Vim provides two handy motions for getting around: `[c` and `]c` jump back and forward between changes. If you want to resolve the differences between files, you can do so using the `:diffget` and `:diffput` commands. Check out episodes [32](/e/32) and [33](/e/33) for a detailed demonstration of how to use these commands.

### Further reading

* [`man vimdiff`][man-vimdiff]
* [`:h vimdiff`][vimdiff]
* [`:h :diffthis`][diffthis]
* [`:h :diffoff`][diffoff]
* [`:h :windo`][windo]
* [`:h :vnew`][vnew]
* [`:help 08.7`][08.7]
* [`:h :put`][put]
* [`:h quoteplus`][quoteplus]
* [`:h ctrl-w_s`][w_s]
* [`:h ctrl-w_v`][w_v]
* [pbpaste][]
* [Git and vimdiff][usevim]
* Episode 32 - [Fugitive.vim - working with the git index](/e/32)
* Episode 33 - [Fugitive.vim - resolving merge conflicts with vimdiff](/e/33)

[man-vimdiff]: http://linux.die.net/man/1/vimdiff
[vimdiff]: http://vimdoc.sourceforge.net/htmldoc/diff.html#vimdiff
[08.7]: http://vimdoc.sourceforge.net/htmldoc/usr_08.html#08.7
[diffthis]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffthis
[diffoff]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffoff
[windo]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:windo
[put]: http://vimdoc.sourceforge.net/htmldoc/change.html#:put
[quoteplus]: http://vimdoc.sourceforge.net/htmldoc/gui_x11.html#quoteplus
[w_s]: http://vimdoc.sourceforge.net/htmldoc/windows.html#CTRL-W_S
[w_v]: http://vimdoc.sourceforge.net/htmldoc/windows.html#CTRL-W_v
[pbpaste]: https://developer.apple.com/library/mac/documentation/Darwin/Reference/Manpages/man1/pbpaste.1.html
[vnew]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:vnew
[usevim]: http://usevim.com/2012/03/21/git-and-vimdiff/
