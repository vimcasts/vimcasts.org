--- 
:title: Pasting from Insert mode
:date: 2013/10/11
:poster: /images/posters/paste-from-insert.png
:flattr_id: ""
:duration: 255
:number: 55
:ogg: 
  :url: http://media.vimcasts.org/videos/55/insert-mode-put.ogv
  :size: 5660879
:quicktime: 
  :url: http://media.vimcasts.org/videos/55/insert-mode-put.m4v
  :size: 9093955
:tags: registers, copy-and-paste, insert-mode
:layout: episode
---

We don't have to be in Normal mode to paste the contents of a register. The [`<C-r>{reg}`][cr] command lets us paste a register from Insert mode (and it [works in commandline mode too][ccr]!) Using this command allows us to make changes that can be repeated with [the dot command][dot].

[cr]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r
[ccr]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-r
[dot]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#.


READMORE


In Insert mode, we can use the [`<C-r>{reg}`][cr] command to paste the contents from any of Vim's registers. For example, pressing `<C-r>a` would insert the contents of named register 'a', while pressing `<C-r>0` would insert the contents of [the yank register][yank-register]. In Vim's documentation, it lists a few more registers that can be useful in this context:

<table>
  <tr>
    <th>register</th>
    <th>description</th>
    <tr>
    <td><code>"</code></td>
    <td>the default register</td>
    </tr>
    <tr>
    <td><code>%</code></td>
    <td>the current file name</td>
    </tr>
    <tr>
    <td><code>#</code></td>
    <td>the alternate file name</td>
    </tr>
    <tr>
    <td><code>*</code></td>
    <td>the clipboard contents (X11: primary selection)</td>
    </tr>
    <tr>
    <td><code>+</code></td>
    <td>the clipboard contents</td>
    </tr>
    <tr>
    <td><code>/</code></td>
    <td>the last search pattern</td>
    </tr>
    <tr>
    <td><code>:</code></td>
    <td>the last command-line</td>
    </tr>
    <tr>
    <td><code>.</code></td>
    <td>the last inserted text</td>
    </tr>
    <tr>
    <td><code>-</code></td>
    <td>the last small (less than a line) delete</td>
    </tr>
  </tr>
</table>

Note that the `<C-r>{reg}` commands can also be used at Vim's command line.

### Variations on `<C-r>{reg}`

The `<C-r>{reg}` command comes with a few variations, including [`<C-r><C-r>{reg}`][rr],  [`<C-r><C-o>{reg}`][ro], [`<C-r><C-p>{reg}`][rp]. In the video tutorial, I demonstrate the the difference between `<C-r>{reg}` and `<C-r><C-o>{reg}`, by attempting to complete the Vimgolf challenge, [Words in parens][golf].

We can use `<C-r>"` to insert the text that was just deleted with the `cw` command. That works fine for a one off change, but if we attempt to repeat the change with the dot command, it reproduces the result of the last insertion. In the example, that means using the dot command on `two` produces `(one)`, when we actually want `(two)`.

If we use `<C-r><C-o>"` instead, Vim inserts the contents of the default register literally, using the current value of the default register. In this case, we can use the dot command to repeat the remaining changes. 

### Further reading

* [`:h i_ctrl-r`](http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r)
* [`:h c_ctrl-r`](http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-r)
* [`:h i_ctrl-r_ctrl-o`][ro]
* [Practical Vim][pv], tip 62: Paste from a register
* Vimgolf challenge: [Words in parens][golf]

[golf]: http://vimgolf.com/challenges/5192f96ad8df110002000002
[pv]: http://pragprog.com/book/dnvim/practical-vim
[dot]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#.
[cr]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r
[yank-register]: /e/52
[ro]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r_ctrl-o
[rr]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r_ctrl-r
[rp]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-r_ctrl-p
