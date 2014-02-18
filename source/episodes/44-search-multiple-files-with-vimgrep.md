--- 
:title: Search multiple files with :vimgrep
:date: 2013/03/01
:poster: /images/posters/vimgrep.png
:flattr_id: "1156445"
:duration: 445
:number: 44
:ogg: 
  :url: http://media.vimcasts.org/videos/44/vimgrep.ogv
  :size: 13806112
:quicktime: 
  :url: http://media.vimcasts.org/videos/44/vimgrep.m4v
  :size: 23175625
:tags: arglist, vimgrep, search
:layout: episode
---

`vimgrep` is Vim's built-in command for searching across multiple files. It's not so fast as external tools like ack and git-grep, but it has its uses. `vimgrep` uses Vim's built-in regex engine, so you can reuse the patterns that work with Vim's standard search command. 

READMORE


Have you ever wished that Vim would report your position as you navigate through search matches? For example, by saying: 'match 2 out of 5'.

That's not a feature provided by Vim's search command, but it is a feature supplied by the [quickfix list][quickfix]. We can use the [`:vimgrep`][vimgrep] command to populate the quickfix list with search results from the current file:

    :vimgrep /{pattern}/ %

The [`%` character is a special symbol][percent], which represents the filepath of the active buffer.

The `{pattern}` field behaves more or less as you would expect. You can supply any pattern that would work with Vim's standard search command.

### Searching for the last pattern

You can search for the last pattern in your search history by running:

    :vimgrep /<C-r>// %

On the command line, `<C-r>/` (that is: [`CTRL-R`][cr] followed by `/`) will insert the last search pattern.

### Specifiying the set of files for `vimgrep` to search

When running the `vimgrep` command, we have to specify at least one file for the command to search inside. We could provide:

1. one or more filepaths (separated by whitespace)
2. a wildcard
3. a backtick expression
4. the `##` symbol, representing the arglist

The first three from this list should look familiar if you've watched [Vimcast #42 - Populating the arglist](/e/42).

The [special ## symbol][dubhash] is expanded to represent each of the files from the arglist. It's really handy in this context. Suppose that we wanted to search the same set of files for one pattern, then another pattern, and so on. It would be a drag to have to specify the same set of files again and again:

    :vim /pattern1/ `find . -type f`
    :vim /pattern2/ `find . -type f`
    :vim /pattern3/ `find . -type f`

We can avoid this repetition by populating the arglist with the set of files we want to work with, then using the special symbol `##` (double hash) to reference the arglist:

    :args `find . -type f`
    :vim /pattern1/ ##
    :vim /pattern2/ ##
    :vim /pattern3/ ##

Not having to think about which files you're dealing with frees you up to focus on the more interesting part of the `vimgrep` command: the pattern.

For more ideas on how to specify the set of files for `vimgrep` to look inside, check out these articles on [`ack -f`][ack-f] and [`git ls-files`][git ls-files].

[ack-f]: http://vimcasts.org/blog/2013/03/combining-vimgrep-with-ack--f/
[git ls-files]: http://vimcasts.org/blog/2013/03/combining-vimgrep-with-git-ls-files/

### Navitating the quickfix list

The results from the `vimgrep` command are collected in the quickfix list. We can traverse them with the following commands:

<table>
   <tr>
       <th>Ex command</th>
       <th>unimpaired map</th>
       <th>effect</th>
   </tr>
   <tr>
       <td><code>:cprev[ious]</code></td>
       <td><code>[q</code></td>
       <td>reverse through quickfix list</td>
   </tr>
   <tr>
       <td><code>:cnext</code></td>
       <td><code>]q</code></td>
       <td>advance through quickfix list</td>
   </tr>
   <tr>
       <td><code>:cfirst</code></td>
       <td><code>[Q</code></td>
       <td>go to start of quickfix list</td>
   </tr>
   <tr>
       <td><code>:clast</code></td>
       <td><code>]Q</code></td>
       <td>go to end of quickfix list</td>
   </tr>
</table>

The square-bracket mappings are not built-in to Vim, but are added by Tim Pope's [unimpaired plugin][unimpaired] (which I recommend).

### Vimgrep: pros, cons, and alternatives

I reach for `vimgrep` when I want to use Vim's built-in regex engine. I love being able to test my regular expression in one buffer using the search command, then use the same pattern without modification to search across the entire project. For me, that convenience is the killer feature of `vimgrep`.

On the downside, `vimgrep` isn't as quick as some of the alternatives out there. If you want to search a large codebase and get results fast, then you'd be better off using an external tool like [`git-grep`][gitgrep], [`ack`][ack] or [the silver searcher][ag]. All of these external tools integrate with the quickfix list, and you can find Vim plugins for each of them:

* [fugitive][] provides the `:Ggrep` command
* [Ack.vim][] provides the `:Ack` command
* [ag.vim][] provides the `:Ag` command

The downside to using these external tools it that each uses a different regex syntax from Vim's.

### Further reading

* [`:help quickfix`][quickfix]
* [`:help :vimgrep`][vimgrep]
* [`:help :_%`][percent]
* [`:help :_##`][dubhash]
* [`:help :substitute`][substitute]
* [`:help :global`][global]
* [`:help c_CTRL-R`][cr]
* [`:help quote/`][quote]
* [Practical Vim][pv] - chapter 12: Matching Patterns and Literals
* [Practical Vim][pv] - chapter 16: Compile code and navigate errors with the quickfix list
* [Practical Vim][pv] - chapter 17: Search project-wide with grep, vimgrep, and others
* [unimpaired.vim][unimpaired]

[quickfix]: http://vimdoc.sourceforge.net/htmldoc/quickfix.html#quickfix
[vimgrep]: http://vimdoc.sourceforge.net/htmldoc/quickfix.html#:vimgrep
[cr]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[percent]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:_%
[unimpaired]: https://github.com/tpope/vim-unimpaired
[dubhash]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:_##
[quote]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote/
[substitute]: http://vimdoc.sourceforge.net/htmldoc/change.html#:su
[global]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#:g

[gitgrep]: http://www.kernel.org/pub/software/scm/git/docs/git-grep.html
[fugitive]: https://github.com/tpope/vim-fugitive
[ack]: http://betterthangrep.com/
[ack.vim]: https://github.com/mileszs/ack.vim
[ag]: https://github.com/ggreer/the_silver_searcher
[ag.vim]: https://github.com/rking/ag.vim
[pv]: http://pragprog.com/book/dnvim/practical-vim
