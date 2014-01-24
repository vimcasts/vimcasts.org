--- 
:title: Selecting columns with visual block mode
:date: 2010/06/20
:poster: /images/posters/visual_block.png
:flattr_id: "31947"
:duration: 261
:number: 22
:ogg: 
  :url: http://media.vimcasts.org/videos/22/visual_block.ogv
  :size: 5721437
:quicktime: 
  :url: http://media.vimcasts.org/videos/22/visual_block.m4v
  :size: 8418264

---

If you want to edit several adjacent lines with a similar format, you might save a lot of time by making a columnar selection. This episode will demonstrate how to achieve this using Vim's visual block mode.


READMORE


[Visual block mode][v_block] allows you to select a rectangular section of text. From normal mode, you can enter visual block mode by pressing `ctrl-v`. 

In most text editing environments, if you want to replace some text, you can just start typing and the replacement will overwrite the selection. But Vim's visual modes are similar to normal mode, in that [each key will execute a command][v_commands]. Here are some of the commands covered in this episode:

<table>
  <tr>
    <th>command</th>
    <th>action</th>
  </tr>
  <tr>
    <td><code>c</code></td>
    <td><em>change</em> selection (delete and switch to insert mode)</td>
  </tr>
  <tr>
    <td><code>I</code></td>
    <td><em>insert</em> in front of cursor</td>
  </tr>
  <tr>
    <td><code>A</code></td>
    <td><em>append</em> after cursor</td>
  </tr>
  <tr>
    <td><code>r</code></td>
    <td><em>replace</em> every character in selection</td>
  </tr>
  <tr>
    <td><code>d</code></td>
    <td><em>delete</em> selection</td>
  </tr>
  <tr>
    <td><code>o</code></td>
    <td>toggle cursor to <em>opposite</em> corner</td>
  </tr>
</table>


###Further Reading

* [`:help visual-block`][v_block]
* [`:help visual-operators`][v_commands]
* [`:help blockwise-operators`][v_operators]

[v_block]: http://vimdoc.sourceforge.net/htmldoc/visual.html#visual-block
[v_operators]: http://vimdoc.sourceforge.net/htmldoc/visual.html#blockwise-operators
[v_commands]: http://vimdoc.sourceforge.net/htmldoc/visual.html#visual-operators
