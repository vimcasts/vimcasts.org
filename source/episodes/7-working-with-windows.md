--- 
:title: Working with windows
:date: 2010/02/21
:poster: /images/posters/working_with_windows.png
:flattr_id: "31929"
:duration: 332
:number: 7
:tags: Managing your workspace
---

In Vim, you can view several buffers at once by loading them into multiple windows. This episode demonstrates all the essentials of working with windows: opening, closing, resizing, moving between and rearranging them.



READMORE


###Opening split windows

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>ctrl-w s</code></td>
       <td>split the current window horizontally, loading the same file in the new window</td>
   </tr>
   <tr>
       <td><code>ctrl-w v</code></td>
       <td>split the current window vertically, loading the same file in the new window</td>
   </tr>
   <tr>
       <td><code>:sp[lit]&nbsp;filename</code></td>
       <td>split the current window horizontally, loading <em>filename</em> in the new window</td>
   </tr>
   <tr>
       <td><code>:vsp[lit]&nbsp;filename</code></td>
       <td>split the current window vertically, loading <em>filename</em> in the new window</td>
   </tr>
</table>

###Closing split windows

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>:q[uit]</code></td>
       <td>close the currently active window</td>
   </tr>
   <tr>
       <td><code>:on[ly]</code></td>
       <td>close all windows except the currently active window</td>
   </tr>
</table>

###Changing focus between windows

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>ctrl-w w</code></td>
       <td>cycle between the open windows</td>
   </tr>
   <tr>
       <td><code>ctrl-w h</code></td>
       <td>focus the window to the left</td>
   </tr>
   <tr>
       <td><code>ctrl-w j</code></td>
       <td>focus the window to the down</td>
   </tr>
   <tr>
       <td><code>ctrl-w k</code></td>
       <td>focus the window to the up</td>
   </tr>
   <tr>
       <td><code>ctrl-w l</code></td>
       <td>focus the window to the right</td>
   </tr>
</table>

I have the following lines in my .vimrc file:

```viml
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
```


###Resizing windows

You can resize windows by clicking on the boundary between windows, and dragging it to your prefered size. The following key commands also help:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>ctrl-w +</code></td>
       <td>increase height of current window by 1 line</td>
   </tr>
   <tr>
       <td><code>ctrl-w -</code></td>
       <td>decrease height of current window by 1 line</td>
   </tr>
   <tr>
       <td><code>ctrl-w _</code></td>
       <td>maximise height of current window</td>
   </tr>
   <tr>
       <td><code>ctrl-w |</code></td>
       <td>maximise width of current window</td>
   </tr>
</table>

###Moving windows

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>ctrl-w r</code></td>
       <td>rotate all windows</td>
   </tr>
   <tr>
       <td><code>ctrl-w x</code></td>
       <td>exchange current window with its neighbour</td>
   </tr>
   <tr>
       <td><code>ctrl-w H</code></td>
       <td>move current window to far left</td>
   </tr>
   <tr>
       <td><code>ctrl-w J</code></td>
       <td>move current window to bottom</td>
   </tr>
   <tr>
       <td><code>ctrl-w K</code></td>
       <td>move current window to top</td>
   </tr>
   <tr>
       <td><code>ctrl-w L</code></td>
       <td>move current window to far right</td>
   </tr>
</table>

