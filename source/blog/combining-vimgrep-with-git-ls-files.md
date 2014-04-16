--- 
:title: Combining :vimgrep with git ls-files
:date: 2013/03/07
:tags: vimgrep, The argument list, git, External commands
---

The `vimgrep` command uses Vim's native regular expressions to search the contents of multiple files. There are several ways that we can specify the list of files to look inside, including `*` and `**` wildcards. It would be handy if we could instruct `vimgrep` to look inside all of the files in the current project, excluding those listed in the `.gitignore` file. That's where the [`git ls-files`][git ls-files] command comes in.

[git ls-files]: https://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html


READMORE

<r:snippet name="announcement"/>

Run [`git help ls-files`][git ls-files] and you'll find the short summary:

> Show information about files in the index and the working tree

We can easily get a list of all of the files tracked in a git repository by running:

    git ls-files

If we wanted to search the contents of those files with `vimgrep`, we could wrap the git command in a backtick expression:

    :vimgrep /{pattern}/g `git ls-files`

Alternatively, we could use the `git ls-files` command to populate the arglist. Then we could use the special symbol [##][] as the final argument for the `vimgrep` command:

    :args `git ls-files`
    :vimgrep /{pattern}/g ##

The [##][] symbol is expanded to represent the filepath of each buffer in the arglist. [Episode #42][42] of Vimcasts goes into more detail on [populating the arglist][42], and [Episode #44][44] of Vimcasts goes into more detail on how to [search multiple files with :vimgrep][44].

### Watch out: `git ls-files` omits untracked files

There's one thing to watch out for if you use this technique: `git ls-files` only lists *files in the index and working tree*. The command is blind to untracked files. In other words, if you create a new file, it won't show up in the output of `git ls-files` until you run:

    git add path/to/newfile

You can view the list of untracked files by running `git ls-files --others`.

### There's always git-grep too

Of course, git also provides the [`git-grep`][gg] command, and the [fugitive][] plugin provides a `:Ggrep` wrapper for it. [Episode 35][35] covers `:Ggrep` in more detail. Even so, it's handy to know that `git ls-files` can be combined with `vimgrep`, for those times when you've got a complex Vim regular expression, and you want to test it against multiple files.

[ggrep]: http://vimcasts.org/e/35
[git ls-files]: https://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html
[##]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:_##
[35]: /e/35
[42]: /e/42
[44]: /e/44
[gg]: https://www.kernel.org/pub/software/scm/git/docs/git-grep.html
