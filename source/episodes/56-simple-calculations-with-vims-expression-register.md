--- 
:title: Simple calculations with Vim's expression register
:date: 2013/10/16
:poster: /images/posters/expression-register-maths.png
:flattr_id: ""
:duration: 242
:ogg: 
  :url: http://media.vimcasts.org/videos/56/expression-register.ogv
  :size: 4704449
:quicktime: 
  :url: http://media.vimcasts.org/videos/56/expression-register.m4v
  :size: 8247836

---

The [expression register][quote=] lets us evaluate a snippet of Vimscript code. This is handy when you need to perform simple calculations and insert the result into the document.

[quote=]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote=


READMORE

<r:snippet name="announcement"/>

From Insert mode, pressing `<C-r>=` drops us into the [expression register][quote=]. We can enter any Vimscript expression. On pressing Enter, Vim evaluates the expression, and inserts the result into the document. For example, if we entered  `2*21` into the expression register, Vim would insert `42` into the document.

In general, we can think of Vim's registers as being variables that hold a string of text, but the [expression register][quote=] is different. This register behaves like a scratchpad that lets us evaluate Vimscript code. If the return value is a string, or if it can be coerced to a string, then Vim will use the result just as though it had been retrieved from any other register.

When we dial up the expression register, Vim drops us into Commandline mode. Usually, Vim's command-line uses a colon as the prompt, which lets us run an Ex command. But in this context the prompt is an equals sign, which tells us we're in the expression register. All of the functionality that is usually present in Commandline mode is available to us in the expression register, including the [`<C-r>{reg}` command][c_ctrl-r].

### Creating a mapping to perform calculations

In the video, I created a mapping on-the-fly to speed up the task of inserting the results of calculations into the document. Here's the mapping:

    nnoremap Q 0yt=A<C-r>=<C-r>"<CR><Esc>

This sets up the `Q` key to perform all of the following work:

<table>
<tr>
<th>command</th>
<th>effect</th>
</tr>
<tr>
<td><code>0</code></td>
<td>move to the start of the line</td>
</tr>
<tr>
<td><code>yt=</code></td>
<td>yank from cursor position up to (but not including) the `=` sign</td>
</tr>
<tr>
<td><code>A</code></td>
<td>move to end of line and switch to Insert mode</td>
</tr>
<tr>
<td><code>&lt;C-r&gt;=</code></td>
<td>dial up the expression register</td>
</tr>
<tr>
<td><code>&lt;C-r&gt;&quot;</code></td>
<td>paste the contents of the default register into the command line</td>
</tr>
<tr>
<td><code>&lt;CR&gt;</code></td>
<td>evaluate the expression register and insert the result into the document</td>
</tr>
<tr>
<td><code>&lt;Esc&gt;</code></td>
<td>return to Normal mode</td>
</tr>
</table>

This mapping is specialized for one particular task, so I wouldn't save it in my vimrc. Instead, I would just create this macro on-the-fly as a throwaway helper to get me through the task at hand.

This is the final command that I demonstrated:

    :'<,'>normal Q

You can read this as follows:

* `:'<,'>` for each selected line
* `normal Q` execute the Normal mode `Q` command, using any user-defined mappings

For a discussion of the `:normal` and `:normal!` commands, check out [chapter 29][29] of Steve Losh's Learn Vimscript the Hard Way. Steve suggests always using `:normal!` and avoiding `:normal`, which is good advice when writing a script, but it doesn't apply in this situation. Think about it!

### Further reading

* [`:h i_ctrl-r`][i_ctrl-r]
* [`:h quote=`][quote=]
* [`:h expression`][expression]
* [`:h usr_41.txt`][41]
* [`:h :normal`][:normal]
* [Chapter 29][29], Learn Vimscript the Hard Way

[quote=]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote=
[expression]: http://vimdoc.sourceforge.net/htmldoc/eval.html#expression
[41]: http://vimdoc.sourceforge.net/htmldoc/usr_41.html#usr_41.txt
[i_ctrl-r]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-R
[c_ctrl-r]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[:normal]: http://vimdoc.sourceforge.net/htmldoc/various.html#:norm
[29]: http://learnvimscriptthehardway.stevelosh.com/chapters/29.html
