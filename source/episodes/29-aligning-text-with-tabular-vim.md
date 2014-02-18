--- 
:title: Aligning text with Tabular.vim
:date: 2011/01/17
:poster: /images/posters/alignment.png
:flattr_id: "118292"
:duration: 311
:number: 29
:ogg: 
  :url: http://media.vimcasts.org/videos/29/alignment.ogv
  :size: 6556323
:quicktime: 
  :url: http://media.vimcasts.org/videos/29/alignment.m4v
  :size: 9300352
:tags: plugins, alignment
:layout: episode
---

There are times when you can improve the readability of your code by lining up the elements on neighbouring lines. In this episode, I demonstrate how this can be achieved using the [Tabular][t] plugin.

[t]: https://github.com/godlygeek/tabular

READMORE


In this episode, I introduce the [Tabular.vim][t] plugin, by [Matt Wozniski][matt], which makes it easy to align regions of text that match a pattern.

### Aligning assignments ###

Before:

<pre class="brush: ruby">
one = 1
two = 2
three = 3
four = 4
</pre>

Running `:Tab /=` produces:

<pre class="brush: ruby">
one   = 1
two   = 2
three = 3
four  = 4
</pre>

### Colon assignments ###

There are a couple of different ways that colon assignments could be aligned. If we start with an example that is not aligned:

<pre class="brush: javascript">
var video = {
    metadata: {
        title: "Aligning assignments"
        h264Src: "/media/alignment.mov",
        oggSrc: "/media/alignment.ogv"
        posterSrc: "/media/alignment.png"
        duration: 320,
    }
}
</pre>

Select the inner block by positioning your cursor inside it and running `vi}` (enable _V_isual mode, and select _i_nner _B_race). Then you could run `:Tab/:` which would produce this result:

<pre class="brush: javascript">
var video = {
    metadata: {
        title     : "Aligning assignments"
        h264Src   : "/media/alignment.mov",
        oggSrc    : "/media/alignment.ogv"
        posterSrc : "/media/alignment.png"
        duration  : 320,
    }
}
</pre>

If you don't like stacking the colons in a column, you could use the [`\zs`][zs] atom to exclude the `:` character from the search match. Running `:Tab /:\zs` produces this result:

<pre class="brush: javascript">
var video = {
    metadata: {
        title:      "Aligning assignments"
        h264Src:    "/media/alignment.mov",
        oggSrc:     "/media/alignment.ogv"
        posterSrc:  "/media/alignment.png"
        duration:   320,
    }
}
</pre>

Be aware that if you work in a team, there may be a house style that you should follow.

### Table markup ###

Here is a scenario outline for cucumber steps, including a pipe-delimited table of examples:

    Scenario Outline: eating
      Given there are &lt;start&gt; cucumbers
      When I eat &lt;eat&gt; cucumbers
      Then I should have &lt;left&gt; cucumbers

      Examples:
        |start|eat|left|
        |12|5|7|
        |20|5|15|

With the cursor positioned anywhere in the table, running `:Tab/|` produces:

    Scenario Outline: eating
      Given there are &lt;start&gt; cucumbers
      When I eat &lt;eat&gt; cucumbers
      Then I should have &lt;left&gt; cucumbers

      Examples:
        | start | eat | left |
        | 12    | 5   | 7    |
        | 20    | 5   | 15   |

## Creating mappings

If you find yourself using a particular token for alignment often, then you might want to save yourself a few keystrokes by creating mappings for normal and visual modes. Here are a few suggestions to get you started:

<pre class="brush: vimscript">
    let mapleader=','
    if exists(&quot;:Tabularize&quot;)
      nmap &lt;Leader&gt;a= :Tabularize /=&lt;CR&gt;
      vmap &lt;Leader&gt;a= :Tabularize /=&lt;CR&gt;
      nmap &lt;Leader&gt;a: :Tabularize /:\zs&lt;CR&gt;
      vmap &lt;Leader&gt;a: :Tabularize /:\zs&lt;CR&gt;
    endif
</pre>

If you were in normal or visual mode, you could type `,a=` to align equals signs. In visual mode, the alignment would apply to the selected lines, but in normal mode tabular would attempt to guess the range.

You could take it a step further, by creating an insert mode mapping to trigger the `:Tabular` command when you type the character that you want to align. Tim Pope shows us how in this [gist][]:

<pre class="brush: vimscript">
inoremap &lt;silent&gt; &lt;Bar&gt;   &lt;Bar&gt;&lt;Esc&gt;:call &lt;SID&gt;align()&lt;CR&gt;a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') &amp;&amp; getline('.') =~# '^\s*|' &amp;&amp; (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
</pre>

If you put this in your vimrc file, then it will call the `:Tabularize` command each time you insert a `|` character.

### Further reading ###

* the [Tabular][t] plugin
* [:help /\zs][zs] - Vim's zero-width 'pattern start' search atom
* [:help /\@<=][plb] - Vim also has a 'positive lookbehind' assertion
* Tim Pope's [insert mode cucumber alignment gist][gist]
* [Align.vim][a] by Charles Campbell - another fine alignment plugin

[a]: http://www.vim.org/scripts/script.php?script_id=294
[t]: https://github.com/godlygeek/tabular
[matt]: https://github.com/godlygeek/
[gist]: https://gist.github.com/287147
[zs]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\zs
[plb]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\@<=
