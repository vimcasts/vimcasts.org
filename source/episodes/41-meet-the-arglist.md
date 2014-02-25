--- 
:title: Meet the arglist
:date: 2013/02/19
:poster: /images/posters/meet_arglist.png
:flattr_id: "1143785"
:duration: 297
:number: 41
:tags: arglist
---

The arglist feature complements Vim's buffer list. In this episode, we'll learn a handful of commands for traversing the arglist. We'll see that it's useful to think of the arglist as a stable subset of the files in the buffer list.

READMORE


Vim keeps a record of the filepaths specified on launch in the argument list (or 'arglist').

    $ vim a.txt b.txt

We can view the contents of this list by running the Ex command (args):

    :args
    [a.txt] b.txt

The square brackets indicate which of the buffers is active.

If we try to quit Vim, it shows a warning:

    :q
    E173 1 more file to edit

This is meant as a friendly reminder: we opened more than one file when we launched Vim, so Vim assumes that we want to edit (or at least look at) the contents of each of those files. To close all files and exit without this warning, we can use the command:

    :qall

## Traversing the arglist

Vim provides four basic Ex commands for traversing the arglist. They are summarized in the following table, along with the mappings provided by the [unimpaired] plugin:

<table>
   <tr>
       <th>Ex command</th>
       <th>unimpaired map</th>
       <th>effect</th>
   </tr>
   <tr>
       <td><code>:prev[ious]</code></td>
       <td><code>[a</code></td>
       <td>reverse through argument list</td>
   </tr>
   <tr>
       <td><code>:next</code></td>
       <td><code>]a</code></td>
       <td>advance through argument list</td>
   </tr>
   <tr>
       <td><code>:first</code></td>
       <td><code>[A</code></td>
       <td>go to start of arglist</td>
   </tr>
   <tr>
       <td><code>:last</code></td>
       <td><code>]A</code></td>
       <td>go to end of arglist</td>
   </tr>
</table>

## The arglist is a stable subset of the buffer list

There's a lot of overlap between the arglist and the buffer list (which is covered in [Vimcast #6 - Working with buffers][6]). 

![The arglist is a stable subset of the buffer list](/images/blog/bufset-argsubset.png)

You can think of the arglist as being a stable subset of the buffer list. The contents of the buffer list can change often, and sometimes without you realizing it. Whereas the arglist will only change its contents when you give an explicit instruction for it to do so.

## Further reading

* [`:help arglist`][arglist]
* [`:help :next`][next]
* [`:help :prev`][prev]
* [`:help :first`][first]
* [`:help :last`][last]
* [`:help :qall`][qall]
* [`:help @:`][repeat]
* [unimpaired] plugin
* [Vimcast #6 - Working with buffers][6]
* [Practical Vim][] tip 37 - Group Buffers into a Collection with the Argument List

[arglist]: http://vimdoc.sourceforge.net/htmldoc/editing.html#arglist
[next]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:next
[prev]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:prev
[first]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:first
[last]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:last
[qall]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:qall
[repeat]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#@:
[unimpaired]: https://github.com/tpope/vim-unimpaired
[6]: /e/6
[Practical Vim]: http://pragprog.com/book/dnvim/practical-vim
