--- 
:title: Working with tabs
:date: 2010/02/28
:poster: /images/posters/working_with_tabs.png
:flattr_id: "31930"
:duration: 197
:number: 8
:ogg: 
  :url: http://media.vimcasts.org/videos/8/working_with_tabs.ogv
  :size: 4805972
:quicktime: 
  :url: http://media.vimcasts.org/videos/8/working_with_tabs.m4v
  :size: 4395212
:tags: tabs, managing-workspace
---

This episode covers the essential commands for working with Vim's tab pages: opening and closing, switching, and moving them.


READMORE


###Opening & closing tabs

The following commands are useful for opening and closing tabs.

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>:tabe[dit]&nbsp;filename</code></td>
       <td>Open filename in a new tab</td>
   </tr>
   <tr>
       <td><code>ctrl-W T</code></td>
       <td>Move current split window into its own tab</td>
   </tr>
   <tr>
       <td><code>:q</code></td>
       <td>Close window, closing tab if it contains a single window</td>
   </tr>
   <tr>
       <td><code>:tabc[lose]</code></td>
       <td>Close the current tab page and all its windows</td>
   </tr>
   <tr>
       <td><code>:tabo[nly]</code></td>
       <td>Close all tabs apart from the current one</td>
   </tr>
</table>


###Switching tabs

When you have multiple tabs open, you can switch between them using the mouse, or the following commands:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>gt</code></td>
       <td>Move to next tab</td>
   </tr>
   <tr>
       <td><code>gT</code></td>
       <td>Move to previous tab</td>
   </tr>
   <tr>
       <td><code>#gt</code></td>
       <td>Move to tab number #</td>
   </tr>
</table>

I'm accustomed to the tab switching shortcuts of Firefox, so to port these into my Vim environment, I include the following in my .vimrc:

<pre class="brush: vimscript">
" For mac users (using the 'apple' key)
map &lt;D-S-]&gt; gt
map &lt;D-S-[&gt; gT
map &lt;D-1&gt; 1gt
map &lt;D-2&gt; 2gt
map &lt;D-3&gt; 3gt
map &lt;D-4&gt; 4gt
map &lt;D-5&gt; 5gt
map &lt;D-6&gt; 6gt
map &lt;D-7&gt; 7gt
map &lt;D-8&gt; 8gt
map &lt;D-9&gt; 9gt
map &lt;D-0&gt; :tablast&lt;CR&gt;

&quot; for linux and windows users (using the control key)
map &lt;C-S-]&gt; gt
map &lt;C-S-[&gt; gT
map &lt;C-1&gt; 1gt
map &lt;C-2&gt; 2gt
map &lt;C-3&gt; 3gt
map &lt;C-4&gt; 4gt
map &lt;C-5&gt; 5gt
map &lt;C-6&gt; 6gt
map &lt;C-7&gt; 7gt
map &lt;C-8&gt; 8gt
map &lt;C-9&gt; 9gt
map &lt;C-0&gt; :tablast&lt;CR&gt;
</pre>

###Rearranging tabs

In MacVim, you can rearrange tabs by dragging and dropping them with the mouse. The following commands can be used in Terminal Vim:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>:tabmove</code></td>
       <td>Move current tab to the end</td>
   </tr>
   <tr>
       <td><code>:tabmove 0</code></td>
       <td>Move current tab to the beginning</td>
   </tr>
   <tr>
       <td><code>:tabmove 1</code></td>
       <td>Move current tab to become the 2nd tab</td>
   </tr>
</table>


