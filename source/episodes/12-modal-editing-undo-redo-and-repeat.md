--- 
:title: "Modal editing: undo, redo and repeat"
:date: 2010/03/28
:poster: /images/posters/modal_editing.png
:flattr_id: "31936"
:duration: 326
:number: 12
:ogg: 
  :url: http://media.vimcasts.org/videos/12/modal_editing.ogv
  :size: 6943276
:quicktime: 
  :url: http://media.vimcasts.org/videos/12/modal_editing.m4v
  :size: 5453158
:tags: undo, repeat
---

Vim's modal editing paradigm - the newbie killer - brings tremendous efficiency if only you can learn to work with it, rather than against it. This episode demonstrates how the undo and repeat commands can benefit from spending short bursts of time in insert mode. 


READMORE


In the video, I demonstrate that `A` plays better with the `.` command than it's longhand equivalent: `$a`. The dot command replays the last edit, but it does not replay motions such as `$`. The `A` command compresses the *move to line end* motion with the *append* command into a single edit, making the motion implicit, and therefore repeatable with the `.` command.

The video also demonstrates that `c{motion}` is a contraction of `d{motion}i`. Having implicit motion means that the `c` command also plays well with the dot command. 



<table>
   <tr>
       <th>Implicit motion command</th>
       <th>Longhand equivalent</th>
   </tr>
   <tr>
       <td><code>c{motion}</code></td>
       <td><code>d{motion}i</code></td>
   </tr>
   <tr>
       <td><code>C</code></td>
       <td><code>d$a</code></td>
   </tr>
   <tr>
        <td><code>s</code></td>
   <td><code>xi</code></td>
   </tr>
   <tr>
        <td><code>S</code></td>
        <td><code>^C</code></td>
   </tr>
   <tr>
        <td><code>I</code></td>
        <td><code>^i</code></td>
   </tr>
   <tr>
        <td><code>A</code></td>
        <td><code>$a</code></td>
   </tr>
   <tr>
        <td><code>o</code></td>
        <td><code>$a&lt;CR&gt;</code></td>
   </tr>
</table>

If you are doing a repetitive task, then composing your brush strokes so that
they can be replayed with the dot command can save you a lot of time. Learning
these 'implicit motion commands' will enable you to exploit the dot command to 
its fullest.

###Further reading

* [`:help vim-modes`][modes]
* [`:help u`][undo]
* [`:help ctlr-r`][redo]
* [`:help .`][dot]
* [Graphical cheat sheet][cheatsheet] - commands marked in red enter insert mode

[modes]: http://vimdoc.sourceforge.net/htmldoc/intro.html#vim-modes
[undo]: http://vimdoc.sourceforge.net/htmldoc/undo.html#undo
[redo]: http://vimdoc.sourceforge.net/htmldoc/undo.html#CTRL-R
[dot]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#.
[cheatsheet]: http://www.viemu.com/vi-vim-cheat-sheet.gif
