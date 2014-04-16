--- 
:title: Combining :vimgrep with ack -f
:date: 2013/03/05
:tags: vimgrep, The argument list, ack, External commands
---

I love the way that ack let's me specify the files to search inside. For starters, ack does the right thing by ignoring the contents of VCS directories, backup files, core dumps etc., which gives a good signal to noise ratio. On top of that, ack provides a convenient syntax for specifying filetypes to include or exclude from the set (see `ack --help-types`). I can target ruby files only with the `--ruby` option, or everything but ruby files with `--noruby`.

READMORE

I also love using `:vimgrep`, because it lets me use Vim's native regular expressions. For me, the ideal project-wide search would combine Vim's regex with ack's method of specifying the set of files to search through. I recently learned about ack's `-f` flag, which makes this combination possible.


<r:snippet name="announcement"/>

[Ack's documentation][doc] describes the `-f` flag as follows:

    -f     Only print the files found, without searching.
           The PATTERN must not be specified.

That means we can easily get a list of all of the source code files in a project by running:

    ack -f

We could load all of those files into Vim's arglist by launching Vim with a backtick expression containing that command:

    vim `ack -f`

Or if Vim was already running, we could populate the arglist with the same set of files by running:

    :args `ack -f`

[Episode #42][42] of Vimcasts goes into more detail on [populating the arglist][42].

On Vim's command line, the special symbol [##][] is expanded to represent the filepath of each buffer in the arglist. If we wanted to search for a pattern inside all of those files, we could do so by running:

    :vimgrep /{pattern}/g ##

This gives the best of both worlds. We get to use `ack` to specify the set of files to look inside, and `:vimgrep` to harness Vim's built-in regex engine. 

This works too:

    :vimgrep /{pattern}/g `ack -f`

I prefer to specify the set of files in one command (`:args ack -f`) and the pattern in a second command (`:vim /{pattern}/g ##`), but that's just my personal preference. [Episode #44][44] of Vimcasts goes into more detail on how to [search multiple files with :vimgrep][44].

[doc]: http://betterthangrep.com/documentation/
[##]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:_##
[42]: /e/42
[44]: /e/44
