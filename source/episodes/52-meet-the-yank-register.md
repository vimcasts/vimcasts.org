--- 
:title: Meet the yank register
:date: 2013/09/30
:poster: /images/posters/yank-register.png
:flattr_id: ""
:duration: 269
:number: 52
:ogg: 
  :url: http://media.vimcasts.org/videos/52/yank-register.ogv
  :size: 5415333
:quicktime: 
  :url: http://media.vimcasts.org/videos/52/yank-register.m4v
  :size: 9394643

---

Vim's default register is not a safe place to keep yanked text that you want to paste later. It's all too easy to clobber the default register with a `d` or `x` command. Luckily, the last yanked text is kept safe in Vim's [yank register][quote0].

[quote0]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote0


READMORE

<r:snippet name="announcement"/>

From Vim's documentation ([`:help quote0`][quote0]):

> Numbered register 0 contains the text from the most recent yank command, unless the command specified another register with ["x].

I call "numbered register 0" *the yank register*. You can paste from the yank register with the command: `"0p`. That comes in really handy when the text you want to paste is no longer present in the default register.

<h3 id="vim-jargon">A note on Vim's jargon</h3>

Vim uses the terms *delete*, *yank*, and *put*, in place of the more standard terminology *cut*, *copy*, and *paste*. Starting with the same letter, put and paste are easily interchangable. Once you get used to the word yank, it becomes synonymous with copy. But Vim's use of the word 'delete' is problematic.

In most contexts, the word delete just means remove. But Vim's delete operation copies the text into a register, then removes it from the document. In other words, Vim's delete operation behaves like a cut.

That raises a question: if Vim's delete command is really a cut operation, does Vim have anything equivalent to a true deletion? The answer is slightly oddball: writing to the 'blackhole register' performs a true deletion.

<table>
  <tr>
    <th>Standard terminology</th>
    <th>Vim's jargon</th>
  </tr>
  <tr>
    <td>paste</td>
    <td>put</td>
  </tr>
  <tr>
    <td>copy</td>
    <td>yank</td>
  </tr>
  <tr>
    <td>cut</td>
    <td>delete</td>
  </tr>
  <tr>
    <td>delete</td>
    <td>delete and write to "blackhole" register</td>
  </tr>
</table>

Nothing returns from the blackhole register. It's the Vim register equivalent of `/dev/null`. To perform a true deletion in Vim, prefix the delete command with `"_` for example: `"_diw` would delete the current word *without* saving a copy in a register.

I find Vim's terminology to be unhelpful, so I try to make a point of describing the `d{motion}` command as "cut the specified text" (rather than delete). Likewise for `x`, `c`, `s`, and so on.

### Further reading

* [`:h quote0`][quote0]
* [`:h quote_`](http://vimdoc.sourceforge.net/htmldoc/change.html#quote_)
* [`:h quotequote`](http://vimdoc.sourceforge.net/htmldoc/change.html#quotequote)
* [`:h :reg`](http://vimdoc.sourceforge.net/htmldoc/change.html#:reg)
* [`:h y`](http://vimdoc.sourceforge.net/htmldoc/change.html#y)
* [`:h p`](http://vimdoc.sourceforge.net/htmldoc/change.html#p)
* [How to use Vim registers][so] on Stack Overflow
* [Practical Vim][pv], Tip 60: Grok Vim's registers

[so]: http://stackoverflow.com/a/1504373/128850
[pv]: http://pragprog.com/book/dnvim/practical-vim
[quote0]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote0
