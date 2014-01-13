--- 
:title: The :edit command
:date: 2010/04/05
:poster: /images/posters/edit_command.png
:flattr_id: "31938"
:duration: 230
:ogg: 
  :url: http://media.vimcasts.org/videos/14/the_edit_command.ogv
  :size: 7333302
:quicktime: 
  :url: http://media.vimcasts.org/videos/14/the_edit_command.m4v
  :size: 7808076

---

This episode focuses on the `:edit` command. I demonstrate how to open files whose location is relative to the current working directory, then I show how to create a mapping which makes it easier to open files in the same directory as the one in the active window.


READMORE

<r:snippet name="announcement"/>

Depending on what arguments you supply, the `:edit` command may do one of 3 things:

* pass it the name of a file, and it will open that file in the current window
* pass it the name of a directory, and it will open a file explorer for that directory
* when called with no arguments, the `:edit` command will revert to the latest saved version of the current file. To discard unwanted changes, you will have to force this command with a trailing '!' bang.

Pressing the `<tab>` key triggers auto-complete for directories and files that match the characters you have typed so far.

If you want to open several files from the same directory, specifying the full path can start to feel like a lot of extra work. You could set the working directory to match that of the file being edited in the current window by issuing the command:

<pre class="brush: vimscript">
:cd %:h
</pre>

However, this can make it harder to locate some files, because you have to climb the directory tree before drilling down again. I prefer to create a set of shortcuts for opening files located in the same directory as the current file:

<pre class="brush: vimscript">
let mapleader=&#x27;,&#x27;
map &lt;leader&gt;ew :e &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
map &lt;leader&gt;es :sp &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
map &lt;leader&gt;ev :vsp &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
map &lt;leader&gt;et :tabe &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
</pre>

Now, I can run `,ew` and it expands to `:e path/to/directory/of/current/file/`. This makes it really easy to open several files from the same directory.

The 'ew' command stands for *open in window*. The other variants stand for *open in split* ('es'), *open in vertical split* ('ev') and *open in tab* ('et') respectively.

### Update

Thanks to [Gary Bernhardt][gb], here is a less horrible way of creating the same mappings:

<pre class="brush: vimscript">
cnoremap %% &lt;C-R&gt;=fnameescape(expand('%:h')).'/'&lt;cr&gt;
map &lt;leader&gt;ew :e %%
map &lt;leader&gt;es :sp %%
map &lt;leader&gt;ev :vsp %%
map &lt;leader&gt;et :tabe %%
</pre>

Additionally, this allows you to expand the directory of the current file anywhere at the command line by pressing `%%`. A top tip from [Max Cantor][mc]!

###Further reading

* [`:help expand`][expand]
* [`:help <C-R>`][reg]
* Stack overflow: [Opening files in the same folder as the current file][stack]

[stack]: http://stackoverflow.com/questions/1708623/opening-files-in-the-same-folder-as-the-current-file-in-vim/1708936#1708936
[expand]: http://vimdoc.sourceforge.net/htmldoc/eval.html#expand%28%29
[reg]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[gb]: http://twitter.com/garybernhardt/status/40292706609532928
[mc]: http://twitter.com/mcantor/status/39157786981957632
