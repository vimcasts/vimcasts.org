--- 
:title: Project-wide find and replace
:date: 2013/03/19
:poster: /images/posters/project_substitute.png
:flattr_id: "1189004"
:duration: 385
:number: 45
:ogg: 
  :url: http://media.vimcasts.org/videos/45/project_substitute.ogv
  :size: 8171536
:quicktime: 
  :url: http://media.vimcasts.org/videos/45/project_substitute.m4v
  :size: 13422810

---

Vim doesn't have a built-in command for project-wide find and replace operations, but we can perform this task by combining primitive Ex commands such as `:substitute`, `:argdo`, and `:vimgrep`. We'll look at two possible strategies: first using the arglist, then the quickfix list.

READMORE


In the video, I find all occurrences of `Vimcasts.com` and change them to `Vimcasts.org`. I show two different ways of doing it. This builds on material that was introduced in episodes [41][], [42][], [43][], and [44][].

### Strategy #1 - run :substitute across all project files

The first strategy is to populate the arglist with all of the files in the project, then run the substitute command against them all:

    :args *.txt
    :argdo %s/Vimcasts\.\zscom/org/ge
    :argdo update

This may mean that the substutite command runs in buffers that don't contain a match.

### Strategy #2 - run :substitute across project files that contain a match

The second strategy breaks the substitute command into two steps: find all matches, then run the substitute command only in those buffers that contain a match. Here are the steps:

    :args *.txt
    :vimgrep /Vimcasts\.\zscom/g ##
    :Qargs
    :argdo %s/Vimcasts\.\zscom/org/ge
    :argdo update

This uses a custom `:Qargs` command to prune the arglist of buffers that don't contain a match.

### The :Qargs helper command

The custom `:Qargs` command sets the arglist to contain each of the files referenced by the quickfix list. You add it to Vim by copying these lines into your vimrc file:

<pre class="brush: vimscript">
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
</pre>

Or you could install the [vim-qargs][qargs] plugin from github. Credit where due: I adapted this code from [a Stack Overflow solution][qfdo] posted by Dr Al.

### Proposal: :cdo

Vim needs a `:cdo {cmd}` command. It would behave like the [`:argdo`][argdo] and [`:bufdo`][bufdo] commands, except that it would iterate through the quickfix list. The `:cdo {cmd}` command would work as follows:

    :cfirst
    :{cmd}
    :cnfile
    :{cmd}
    etc.

If such a command existed, then we could refine Strategy #2, removing the `:Qargs` step:

    :args *.txt
    :vimgrep /Vimcasts\.\zscom/g ##
    :cdo %s/Vimcasts\.\zscom/org/ge
    :cdo update

**UPDATE** on June 2nd, 2013, [Yegappan submitted a patch][patch] to add native `:cdo` and `:ldo` commands to Vim's core.

### :cdo implementations in the wild

Henrik Nye created a [`:Qdo` command][qdo] in his fork of [my Qargs plugin][qargs]. This takes the slightly dirty approach of populating the arglist from the contents of the quickfix list, then using the built-in `:argdo` command to iterate over the resulting arglist. Of course, this has the side-effect that it changes the contents of the arglist. That's tolerable, but not ideal. Henrik has written up how to [use `:Qdo` for project wide search and replace][pug].

Peter Jaros created [`vim-cdo`][cdo], which includes `:Cdo` as well as `:Ldo` for operating on the location list. Peter's plugin differs slightly from the formula I described above, because it effectively uses `:cnext` instead of `:cnfile`.

In the comments, Vincent Velociter pointed out [another implementation][efiquest] that creates both `:Qfdo` and `:Qfdofile` commands.

### Further reading

* [`:help /\zs`][zs]
* [`:help :argdo`][argdo]
* [`:help :bufdo`][bufdo]
* [`:help :vimgrep`][vimgrep]
* [`:help :substitute`][substitute]
* Vimcast #41 - [Meet the arglist][41]
* Vimcast #42 - [Populating the arglist][42]
* Vimcast #43 - [Using :argdo to change multiple files][43]
* Vimcast #44 - [Search multiple files with :vimgrep][44]
* [Practical Vim][pv] tip 77 - Stake the boundaries of a match
* [Practical Vim][pv] tip 96 - Find and replace across multiple files
* [Project wide search and replace in Vim with Qdo][pug]
* Stack overflow: [Search & replace using quickfix list in Vim][so]
* Stack overflow: [How to do search & replace with ack in Vim][qfdo]
* [Yegappan's patch for native `:cdo` and `:ldo`][patch]

[substitute]: http://vimdoc.sourceforge.net/htmldoc/change.html#:s
[vimgrep]: http://vimdoc.sourceforge.net/htmldoc/quickfix.html#:vim
[pv]: http://pragprog.com/book/dnvim/practical-vim
[qargs]: https://github.com/nelstrom/vim-qargs
[zs]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\zs
[argdo]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:argdo
[bufdo]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:bufdo
[qdo]: https://github.com/henrik/vim-qargs/blob/22a27f3745198b942b3d2b8bec31d4daa964aa28/plugin/qargs.vim#L5
[cdo]: https://github.com/Peeja/vim-cdo
[pug]: http://henrik.nyh.se/2012/07/project-wide-search-and-replace-in-vim-with-qdo/
[41]: /e/41
[42]: /e/42
[43]: /e/43
[44]: /e/44
[so]: http://stackoverflow.com/a/5686810/6962
[qfdo]: http://stackoverflow.com/a/4793316/128850
[efiquest]: http://efiquest.org/2009-02-19/32/
[patch]: https://groups.google.com/forum/#!msg/vim_dev/dfyt-G6SMec/_6h8pDUpeZMJ
