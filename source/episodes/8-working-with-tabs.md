--- 
:title: Working with tabs
:date: 2010/02/28
:poster: /images/posters/working_with_tabs.png
:flattr_id: "31930"
:duration: 197
:number: 8
:tags: Managing your workspace
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

```viml
" For mac users (using the 'apple' key)
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" for linux and windows users (using the control key)
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>
```

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


