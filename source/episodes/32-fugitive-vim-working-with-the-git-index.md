--- 
:title: Fugitive.vim - working with the git index
:date: 2011/04/29
:poster: /images/posters/fugitive_2.png
:flattr_id: "177652"
:duration: 701
:number: 32
:ogg: 
  :url: http://media.vimcasts.org/videos/32/fugitive_2.ogv
  :size: 19217222
:quicktime: 
  :url: http://media.vimcasts.org/videos/32/fugitive_2.m4v
  :size: 25748543
:tags: plugins, fugitive, git, workflow, vimdiff
:layout: episode
---

The fugitive plugin provides an interactive status window, where you can easily stage and review your changes for the next commit. The `:Gdiff` command visualizes the changes made to a file, by comparing the working copy with the index. In this episode, we'll learn how to stage hunks of changes to the index without using the `git add --patch` command.

*This is the second of a five part series on fugitive.vim. In the next episode, we'll learn how to resolve a git merge conflict by performing a 3-way vimdiff.*

READMORE


### The Gstatus window

The `:Gstatus` command opens a status window. The contents closely resemble the output from running `git status` in the shell, but fugitive makes the window interactive. You can jump directly between files with `ctrl-n` and `ctrl-p`.

<table>
  <tr>
    <th>command</th>
    <th>affect</th>
  </tr>
  <tr>
    <td><code>-</code></td>
    <td>add/reset file (works in visual mode too)</td>
  </tr>
  <tr>
  <td><code>&lt;Enter&gt;</code></td>
    <td>open current file in the window below</td>
  </tr>
  <tr>
    <td><code>p</code></td>
    <td>run `git add --patch` for current file</td>
  </tr>
  <tr>
    <td><code>C</code></td>
    <td>invoke <code>:Gcommit</code></td>
  </tr>
</table>

### Working with the git index

The git index is where you put changes that you want to be included in the next commit. If you are used to working with the command line git client, you might think of the index as an abstract concept. But with fugitive, you can actually read the index version of a file into a buffer by running:

    :Gedit :path/to/file

If you run `:Gedit` with no arguments from a working tree file, it will open the index version of that file. 
You can always open the index version of the current file by running any one of the following:

    :Gedit
    :Gedit :0
    :Gedit :%

It helps to understand the lifecycle of the index file between two commits. To begin with, the contents of the index and working copy files will be exactly the same as the most recent commit. As you make changes to your working copy, its contents begin to diverge from those of the index file. Staging a file updates the contents of the index file to match those of the working copy. When you commit your work, it is the contents of the index file that are saved with that commit object.

![Index Lifecycle](/images/blog/index-lifecycle.png)

### Comparing working copy with index version using `:Gdiff`

When you run:

    :Gdiff

on a work tree file without any arguments, fugitive performs a vimdiff against the index version of the file. This opens a vertical split window, with the index file on the left and the working copy on the right. The files always appear in that order, so you can commit that to memory.

### Wholesale reconciliation

The `:Gread` and `:Gwrite` commands can either add a file to the index or reset the file, depending on where they are called from. The following table and diagrams summarize the possibilities:

<table>
  <tr>
    <th>command</th>
    <th>active window</th>
    <th>affect</th>
  </tr>
  <tr>
    <td><code>:Gwrite</code></td>
    <td>working copy</td>
    <td>stage file</td>
  </tr>
  <tr>
    <td><code>:Gread</code></td>
    <td>working copy</td>
    <td>checkout file</td>
  </tr>
  <tr>
    <td><code>:Gwrite</code></td>
    <td>index</td>
    <td>checkout file</td>
  </tr>
  <tr>
    <td><code>:Gread</code></td>
    <td>index</td>
    <td>stage file</td>
  </tr>
</table>

![Gread Gwrite Matrix](/images/blog/Gread-Gwrite-matrix.png)

### Piecemeal reconciliation

Vim's built in `:diffget` and `:diffput` commands work a bit like `:Gread` and `:Gwrite`, except that they are more granular. Whereas `:Gread` will completely overwrite the current buffer with the contents of the other buffer, `:diffget` will only pull in a patch at a time.

<table>
<tr>
  <th>command</th>
  <th>active window</th>
  <th>affect</th>
</tr>
<tr>
  <td><code>:diffput</code></td>
  <td>working copy</td>
  <td>stage hunk</td>
</tr>
<tr>
  <td><code>:diffget</code></td>
  <td>working copy</td>
  <td>checkout hunk</td>
</tr>
<tr>
  <td><code>:diffput</code></td>
  <td>index</td>
  <td>checkout hunk</td>
</tr>
<tr>
  <td><code>:diffget</code></td>
  <td>index</td>
  <td>stage hunk</td>
</tr>
</table>

![Diffget Diffput Matrix](/images/blog/diffget-diffput-matrix.png)

### Further reading

* [the git index][gi1] ([more][gi7])
* [solarized colorscheme][solarized]
* [`:help :diffget`][dfg]
* [`:help :diffput`][dfp]
* [`:help do`][do]
* [`:help dp`][dp]

[gi1]: http://book.git-scm.com/1_the_git_index.html
[gi7]: http://book.git-scm.com/7_the_git_index.html
[solarized]: http://ethanschoonover.com/solarized
[dfp]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffput
[dp]: http://vimdoc.sourceforge.net/htmldoc/diff.html#dp
[dfg]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffget
[do]: http://vimdoc.sourceforge.net/htmldoc/diff.html#do
