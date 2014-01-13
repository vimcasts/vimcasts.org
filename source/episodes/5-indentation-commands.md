--- 
:title: Indentation commands
:date: 2010/02/08
:poster: /images/posters/indentation_commands.png
:flattr_id: "31927"
:duration: 341
:number: 5
:ogg: 
  :url: http://media.vimcasts.org/videos/5/indentation_commands.ogv
  :size: 11178639
:quicktime: 
  :url: http://media.vimcasts.org/videos/5/indentation_commands.m4v
  :size: 11037200

---

This episode covers the commands for shifting text left and right (`<` and `>`), and also goes over the auto indent command (`=`).


READMORE

<r:snippet name="announcement"/>

To add TextMate's key mappings, put the following in your `.vimrc`:

<pre class="brush: vimscript">
nmap &lt;D-[&gt; &lt;&lt;
nmap &lt;D-]&gt; &gt;&gt;
vmap &lt;D-[&gt; &lt;gv
vmap &lt;D-]&gt; &gt;gv
</pre>

###Further reading

* [:help shift-left-right][shifting]
* [:help =][autoformat]
* [:help text-objects][textobjects]
* [Formatting with an external program][autoformat]

[textobjects]: http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
[shifting]: http://vimdoc.sourceforge.net/htmldoc/change.html#shift-left-right
[autoformat]: http://vimdoc.sourceforge.net/htmldoc/change.html#=
[equalprg]: http://vim.runpaint.org/editing/formatting-with-an-external-program/