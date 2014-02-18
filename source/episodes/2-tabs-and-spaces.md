--- 
:title: Tabs and Spaces
:date: 2010/01/05
:poster: /images/posters/tabs_and_spaces.png
:flattr_id: "31923"
:duration: 382
:number: 2
:ogg: 
  :url: http://media.vimcasts.org/videos/2/tabs_and_spaces.ogv
  :size: 8675696
:quicktime: 
  :url: http://media.vimcasts.org/videos/2/tabs_and_spaces.m4v
  :size: 9362665
:tags: whitespace
:layout: episode
---

Vim offers very granular control over whitespace. This episode explains the purpose of `tabstop`, `softtabstop`, `shiftwidth` and `expandtab` settings, and illustrates how Vim behaves using various combinations of these.


READMORE


The following combinations are demonstrated in the video:

<pre class="brush: vimscript">
set ts=8 sts=0 sw=8 noexpandtab	" default settings
set ts=8 sts=0 sw=8 expandtab
set ts=8 sts=8 sw=8 expandtab
set ts=8 sts=4 sw=4 expandtab
set ts=8 sts=4 sw=4 noexpandtab
set ts=4 sts=4 sw=4 noexpandtab
</pre>

If you prefer to work with tab characters then it is a good idea to ensure that `tabstop == softtabstop`. This makes it less likely that you'll end up with a mixture of tabs and spaces for indentation.

If you prefer to work with spaces, then it is preferable to ensure that `softtabstop == shiftwidth`. This way, you can expect the same number of spaces to be inserted whether you press the tab key in insert mode, or use the indentation commands in normal/visual modes.

The following snippet of vimscript allows you to assign the same value to tabstop, softtabstop and shiftwidth simultaneously:


<pre class="brush: vimscript">
&quot; Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input(&#x27;set tabstop = softtabstop = shiftwidth = &#x27;)
  if l:tabstop &gt; 0
    let &amp;l:sts = l:tabstop
    let &amp;l:ts = l:tabstop
    let &amp;l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon &#x27;tabstop=&#x27;.&amp;l:ts
    echon &#x27; shiftwidth=&#x27;.&amp;l:sw
    echon &#x27; softtabstop=&#x27;.&amp;l:sts
    if &amp;l:et
      echon &#x27; expandtab&#x27;
    else
      echon &#x27; noexpandtab&#x27;
    endif
  finally
    echohl None
  endtry
endfunction
</pre>

To invoke this command, go into normal mode (by pressing escape) then run:

<pre class="brush: vimscript">
:Stab
</pre>

Then hit enter. You will see this:

<pre class="brush: vimscript">
set tabstop = softtabstop = shiftwidth = 
</pre>

Enter the size that you want to assign to those settings, and hit enter. A summary line then shows the value of each setting, as well as showing whether or not expandtab is enabled. If you hit enter without providing a value, then the tab settings are not affected.

You can also call the summary line by itself. I've mapped this to `ctrl-shift-tab` for convenience. Feel free to modify the mappings, and the funcionality to suit your preferences.

###Further Reading

* [`:help tabstop`][tabstop]
* [`:help softtabstop`][softtabstop]
* [`:help shiftwidth`][shiftwidth]
* [`:help expandtab`][expandtab]

When I started researching this episode, I asked a question on [StackOverflow.com][question]. The answers that came in seemed to be at odds with each other, which demonstrated to me that there is a lot of confusion over the subject. I'd like to thank [too_much_php][too_much_php] for providing [the vimscript sample][vimscript] which I have adapted for my preferences. If it proves useful to yourself, why not show your gratitude by upvoting his answer?

[tabstop]: http://vimdoc.sourceforge.net/htmldoc/options.html#%27tabstop%27
[softtabstop]: http://vimdoc.sourceforge.net/htmldoc/options.html#%27softtabstop%27
[shiftwidth]: http://vimdoc.sourceforge.net/htmldoc/options.html#%27shiftwidth%27
[expandtab]: http://vimdoc.sourceforge.net/htmldoc/options.html#%27expandtab%27
[question]: http://stackoverflow.com/questions/1562336/tab-vs-space-preferences-in-vim
[vimscript]: http://stackoverflow.com/questions/1562336/tab-vs-space-preferences-in-vim/1610732#1610732
[too_much_php]: http://stackoverflow.com/users/28835/too-much-php
