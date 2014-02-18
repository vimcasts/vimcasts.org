--- 
:title: Working with buffers
:date: 2010/02/14
:poster: /images/posters/working_with_buffers.png
:flattr_id: "31928"
:duration: 208
:number: 6
:ogg: 
  :url: http://media.vimcasts.org/videos/6/buffers_listed_and_hidden.ogv
  :size: 4834378
:quicktime: 
  :url: http://media.vimcasts.org/videos/6/buffers_listed_and_hidden.m4v
  :size: 5715585
:tags: buffers, managing-workspace
:layout: episode
---

Introducing the buffer list, and commands for switching between buffers. This episode also covers the concept of 'hidden' buffers, and shows how to deal with them.


READMORE


###Working with buffers

These commands show and navigate through the buffer list:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   <tr>
   <tr>
       <td><code>:ls</code></td>
       <td>show the buffer list</td>
   <tr>
   <tr>
       <td><code>:bn</code></td>
       <td>open the next buffer in the current window (cycles from the end of
       the list to the beginning).</td>
   <tr>
   <tr>
       <td><code>:bp</code></td>
       <td>open the previous buffer in the current window (cycles from the start of
       the list to the end).</td>
   <tr>
   <tr>
       <td><code>CTRL-^</code></td>
       <td>switch to the alternate file</td>
   <tr>
</table>

###Dealing with hidden buffers

A buffer is marked as 'hidden' if it has unsaved changes, and it is not
currently loaded in a window. 

If you try and quit Vim while there are hidden buffers, you will raise an
error: *E162: No write since last change for buffer "a.txt"*.

In this scenario, you can do any of the following:


<table>
   <tr>
       <th>command</th>
       <th>action</th>
   <tr>
   <tr>
       <td><code>:w</code></td>
       <td>save the changes to a file</td>
   <tr>

   <tr>
       <td><code>:e!</code></td>
       <td>restore the original file</td>
   <tr>
   <tr>
       <td><code>:bd!</code></td>
       <td>forcibly remove the buffer from the buffer list, discarding any changes</td>
   <tr>
   <tr>
       <td><code>:q!</code></td>
       <td>force Vim to quit, discarding changes to all modified buffers</td>
   <tr>
</table>

By default, Vim makes it difficult to create hidden buffers. To make Vim more liberal about hidden buffers, put the following in your .vimrc:

    set hidden

