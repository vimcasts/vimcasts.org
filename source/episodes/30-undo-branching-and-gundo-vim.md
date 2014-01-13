--- 
:title: Undo branching and Gundo.vim
:date: 2011/02/23
:poster: /images/posters/undo_tree.png
:flattr_id: "137468"
:duration: 390
:number: 30
:ogg: 
  :url: http://media.vimcasts.org/videos/30/undo_tree.ogv
  :size: 9435598
:quicktime: 
  :url: http://media.vimcasts.org/videos/30/undo_tree.m4v
  :size: 12483269

---

The undo command is almost universally available in software today. Being able to rollback unwanted changes can be a real timesaver. In most applications you can only go backwards and forwards linearly, but Vim keeps your changes in a tree structure, which means that you can retrieve edits from distant branches in your history. This episode will show you how.

READMORE

<r:snippet name="announcement"/>

Vim maintains your undo history in a tree structure. This is a powerful feature, which lets you switch back to any previous state of your document (up to the value of [`undolevels`][ul]), but it's not easy to understand. Vim's interface to the undo tree is made up of the familiar undo and redo operations, as well as a handful of ways to traverse the list of changes in chronological order. These commands enable you to shine a light on every corner of the undo tree, but it can still be difficult to get a sense of what you are looking at. Nodes that are adjacent in chronological order may be several steps apart on the graph.

A much more intuitive interface to the undo tree is now available if you install the excellent [Gundo plugin][gundo], by [Steve Losh][]. This draws an ASCII representation of the undo tree, which you can easily navigate with regular Vim motion commands. Pressing the enter key when your cursor is positioned on a node will revert the document to the specified state.

I recommend installing the Gundo plugin. Being able to retrieve any state from your undo history with confidence will change the way you work. But I would still encourage you to try and understand the way that Vim's undo tree works. [Read the user guide][32] and the [documentation][tree]. Watch the video, and play with the interactive visualization on this page to get a feel for how Vim's commands allow you to traverse the graph. You'll need it one day.

<div id="vim-history-visualization"></div>

The `undo` and `redo` commands can move forwards and backwards along the *mainline* branch (represented in the visualisation as a solid dark line), but they are not able to switch between branches. When you step along a single track with undo and redo, each update corresponds to a coherent edit, so you can follow the evolution of your document.

The `g-` and `g+` commands traverse the list of historical states of the document. This means that they are capable of switching from one undo branch to another. Beware that jumping between branches can be disorienting, just like time travel. Nevertheless, this powerful feature means that you are never barred from revisiting an earlier state of your document.

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>u</code></td>
       <td>undo the last change</td>
   </tr>
   <tr>
       <td><code>ctrl-r</code></td>
       <td>redo one change which was undone</td>
   </tr>
   <tr>
       <td><code>g-</code></td>
       <td>go to older text state</td>
   </tr>
   <tr>
       <td><code>g+</code></td>
       <td>go to newer text state</td>
   </tr>
   <tr>
       <td><code>:earlier {N}s</code></td>
       <td>Go the the older text state about {N} seconds before</td>
   </tr>
</table>

Note that the document timeline records a time-stamp for each historical state, which makes it possible to revert the document to how it looked a particular number of seconds, minutes, hours or days before the current state. I can assure you, running `:earlier 20s` has saved my bacon on more than one occasion!

### Further reading

* [`:help undo-tree`][tree]
* [`:help usr_32.txt`][32]
* Homepage for the [Gundo.vim plugin][gundo]
* [Source code][viz] for undo tree visualization

[tree]: http://vimdoc.sourceforge.net/htmldoc/undo.html#undo-tree
[32]: http://vimdoc.sourceforge.net/htmldoc/usr_32.html
[ul]: http://ideavim.sourceforge.net/vim/options.html#vim.'undolevels'
[gundo]: http://sjl.bitbucket.org/gundo.vim/
[Steve Losh]: http://stevelosh.com/
[viz]: https://github.com/nelstrom/Vim-undo-tree-visualization
