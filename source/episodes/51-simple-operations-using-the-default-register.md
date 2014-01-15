--- 
:title: Simple operations using the default register
:date: 2013/09/27
:poster: /images/posters/default-register.png
:flattr_id: ""
:duration: 247
:number: 51
:ogg: 
  :url: http://media.vimcasts.org/videos/51/default-register.ogv
  :size: 5676820
:quicktime: 
  :url: http://media.vimcasts.org/videos/51/default-register.m4v
  :size: 9777137

---

Vim's [default register][quotequote] makes it easy to perform some of the most basic types of cut, copy, and paste operations. That's partly thanks to the [`p`][p] command, which behaves differently depending on whether the default register contains a characterwise or linewise region of text.

[quotequote]: http://vimdoc.sourceforge.net/htmldoc/change.html#quotequote
[p]: http://vimdoc.sourceforge.net/htmldoc/change.html#p


READMORE

<r:snippet name="announcement"/>

From Vim's documentation ([`:h quotequote`][quotequote]):

> Vim fills this register with text deleted with the "d", "c", "s", "x" commands or copied with the yank "y" command, regardless of whether or not a specific register was used.

Vim calls this the *unnamed register*, which is a sweet [oxymoron][]. I prefer to call it the *default register*.

Here are descriptions of a few simple commands that interact with the default register:

<table>
<tr>
<th>command</th>
<th>description</th>
</tr>
<tr>
<td>x</td>
<td>cut one character and write it to default register</td>
</tr>
<tr>
<td>dd</td>
<td>cut one line and write it to default register</td>
</tr>
<tr>
<td>yy</td>
<td>copy one line into default register</td>
</tr>
<tr>
<td>p</td>
<td>put text from default register after cursor</td>
</tr>
</table>

There's more to the `p` command than meets the eye: its behavior differs subtly depending on whether the register contains a characterwise or linewise region of text (see [`:h linewise-register`][linewise]). When the default register contains a characterwise region of text, the `p` command puts the text *after the current character*. Whereas when the default register contains a linewise region, the `p` command puts the text *after the current line*.

Even though `xp`, `ddp`, and `yyp` each consist of two separate commands, we can think of each pair as forming an aggregate command:

<table>
<tr>
<th>commands</th>
<th>description</th>
</tr>
<tr>
<td>xp</td>
<td>toggle characters</td>
</tr>
<tr>
<td>ddp</td>
<td>toggle lines</td>
</tr>
<tr>
<td>yyp</td>
<td>duplicate line</td>
</tr>
</table>

You can explicitly tell Vim that you want to paste the contents of the default register by prefixing the `p` command with `""` (that is, doublequote twice). Of course, `""p` and `p` are equivalent, since the default register is used by default.

### Further reading

* :h [`linewise-register`][linewise]
* :h [`quotequote`][quotequote]
* :h [`x`](http://vimdoc.sourceforge.net/htmldoc/change.html#x)
* :h [`dd`](http://vimdoc.sourceforge.net/htmldoc/change.html#dd)
* :h [`yy`](http://vimdoc.sourceforge.net/htmldoc/change.html#yy)
* :h [`p`](http://vimdoc.sourceforge.net/htmldoc/change.html#p)

[oxymoron]: http://www.wordnik.com/words/oxymoron
[linewise]: http://vimdoc.sourceforge.net/htmldoc/motion.html#linewise
[quotequote]: http://vimdoc.sourceforge.net/htmldoc/change.html#quotequote