--- 
:title: Fugitive.vim - a complement to command line git
:date: 2011/04/22
:poster: /images/posters/fugitive_1.png
:flattr_id: "173139"
:duration: 507
:number: 31
:tags: plugins, fugitive, git, workflow
---

[The fugitive plugin][f], by Tim Pope, is a git wrapper for Vim. It  complements the command line interface to git, but doesn't aim to replace it. In this episode, we'll see how some of fugitive's commands can streamline your workflow.

*This is the first of a five part series on fugitive.*

[f]: https://github.com/tpope/vim-fugitive

READMORE


Using the `:Git` command, you can run any arbitrary git command from inside Vim. I prefer to switch to the shell for anything that generates a log of output, such as `git log` for example. But commands that generate little or no output are fair game for running from inside Vim (`:Git checkout -b experimental` for example).

At Vim's command line, [the `%` symbol has a special meaning][special]: it expands to the full path of the current file. You can use this to run any git command that expects a filepath as an argument, making the command act on the current file. But fugitive also provides a few convenience methods, some of which are summarized in this table:

<table>
   <tr>
       <th>git</th>
       <th>fugitive</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>:Git add %</code></td>
       <td><code>:Gwrite</code></td>
       <td>Stage the current file to the index</td>
   </tr>
   <tr>
       <td><code>:Git checkout %</code></td>
       <td><code>:Gread</code></td>
       <td>Revert current file to last checked in version</td>
   </tr>
   <tr>
       <td><code>:Git rm %</code></td>
       <td><code>:Gremove</code></td>
       <td>Delete the current file and the corresponding Vim buffer</td>
   </tr>
   <tr>
       <td><code>:Git mv %</code></td>
       <td><code>:Gmove</code></td>
       <td>Rename the current file and the corresponding Vim buffer</td>
   </tr>
</table>

The `:Gcommit` command opens up a commit window in a split window. One advantage to using this, rather than running `git commit` in the shell, is that you can use Vim's [keyword autocompletion][cpt] when composing your commit message.

The `:Gblame` command opens a vertically split window containing annotations for each line of the file: the last commit reference, with author and timestamp. The split windows are bound, so that when you scroll one, the other window will follow.

### Further Reading

* [`:help cmdline-special`][special]
* [`:help :_%`][percent]
* [`ctlr-n`/`ctrl-p`][np] keyword autocompletion
* [`:help 'complete'`][cpt]
* [`:help :Git`][g]
* [`:help :Gwrite`][w]
* [`:help :Gread`][r]
* [`:help :Gremove`][rm]
* [`:help :Gmove`][mv]
* [`:help :Gcommit`][ci]
* [`:help :Gblame`][blame]

[np]: http://vimdoc.sourceforge.net/htmldoc/insert.html#compl-generic
[percent]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:_%
[special]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#cmdline-special
[cpt]: http://vimdoc.sourceforge.net/htmldoc/options.html#'complete'
[g]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L42-44
[w]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L108-114
[r]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L99-103
[rm]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L149-153
[mv]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L143-147
[ci]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L62-72
[blame]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L155-160
