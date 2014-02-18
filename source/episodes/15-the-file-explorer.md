--- 
:title: The file explorer
:date: 2010/04/12
:poster: /images/posters/the_file_explorer.png
:flattr_id: "31940"
:duration: 336
:number: 15
:ogg: 
  :url: http://media.vimcasts.org/videos/15/the_file_explorer.ogv
  :size: 9156710
:quicktime: 
  :url: http://media.vimcasts.org/videos/15/the_file_explorer.m4v
  :size: 9566713
:tags: opening-files
:layout: episode
---

This episode demonstrates how Vim's native file browser can be used to explore and manipulate the file system. 


READMORE


The video demonstrates some of the functionality of the [netrw][netrw_plugin] plugin, which is usually distributed with Vim. Note that if the [NERD_tree][ntree_plugin] is installed, then the functionality described in this episode won't work for you.

Exploring the filesystem
------------------------

The file explorer is just another Vim buffer, so you can navigate up and down with `k` and `j` keys, or jump to the bottom with `G`, etc. If it is a large file listing, you may be quicker finding your target by searching for it. 

There are a handful of useful commands for opening the file explorer - either in the current window or a split, focussing on the project root, or the directory of the most recent file edited. This table summarizes:

<table>
   <tr>
       <th>lazy</th>
       <th>mnemonic</th>
       <th>open file explorer</th>
   </tr>
   <tr>
       <td><code>:e.</code></td>
       <td><code>:edit .</code></td>
       <td>at current working directory</td>
   </tr>
   <tr>
       <td><code>:sp.</code></td>
       <td><code>:split .</code></td>
       <td>in split at current working directory</td>
   </tr>
   <tr>
       <td><code>:vs.</code></td>
       <td><code>:vsplit .</code></td>
       <td>in vertical split at current working directory</td>
   </tr>
   <tr>
       <td><code>:E</code></td>
       <td><code>:Explore</code></td>
       <td>at directory of current file</td>
   </tr>
   <tr>
       <td><code>:Se</code></td>
       <td><code>:Sexplore</code></td>
       <td>in split at directory of current file</td>
   </tr>
   <tr>
       <td><code>:Ve</code></td>
       <td><code>:Vexplore</code></td>
       <td>in vertical split at directory of current file</td>
   </tr>
</table>

Manipulating the filesystem
---------------------------

The file explorer includes commands for creating new files and directories, as well as renaming or deleting existing ones. This table summarizes these:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>%</code></td>
       <td>create a new file</td>
   </tr>
   <tr>
       <td><code>d</code></td>
       <td>create a new directory</td>
   </tr>
   <tr>
       <td><code>R</code></td>
       <td>rename the file/directory under the cursor</td>
   </tr>
   <tr>
       <td><code>D</code></td>
       <td>Delete the file/directory under the cursor</td>
   </tr>
</table>

### Further Reading ###

* [`:help netrw`][netrw]
* [`:help :edit`][edit]
* [`:help :Explore`][ex]
* [`:help netrw-%` - create new file][newfile]
* [`:help netrw-d` - create new directory][newdirectory]
* [`:help netrw-R` - renaming files or directories][rename]
* [`:help netrw-D` - deleting files or directories][delete]

[netrw_plugin]: http://www.vim.org/scripts/script.php?script_id=1075
[ntree_plugin]: http://www.vim.org/scripts/script.php?script_id=1658
[netrw]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html
[newfile]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-%
[newdirectory]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-d
[edit]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:edit
[ex]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-explore
[rename]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-R
[delete]: http://vimdoc.sourceforge.net/htmldoc/pi_netrw.html#netrw-D
