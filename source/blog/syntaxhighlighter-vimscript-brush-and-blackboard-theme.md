--- 
:title: SyntaxHighlighter Vimscript brush and Blackboard theme
:date: 2010/04/29
:tags: syntax, colorschemes
---

Here on Vimcasts.org, I use Alex Gorbatchev's [SyntaxHighlighter][sh] to colorize the code excerpts. I couldn't find a syntax 'brush' for Vimscript, so I wrote my own. I also created a color theme based on the Blackboard scheme that I use in Vim (and TextMate). 

[sh]: http://alexgorbatchev.com/wiki/SyntaxHighlighter


READMORE

I have published the Vimscript brush and Blackboard theme on github. You can find them here:

* [Blackboard theme][blackboard]
* [Vimscript syntax][vimscript]

I created these two files, but everything else in the project is by Alex Gorbatchev and the SyntaxHighligher community. The project is not hosted on github, otherwise I would have forked it.

### Vimscript keywords

The Vimscript brush includes a large list of keywords. I copied this list from Vim's own syntax file, which you can open up in Vim by running `:edit $VIMRUNTIME/syntax/vim.vim`. When defining syntax files for Vim, you can use a form of shorthand, e.g. `e[dit]`, which is equivalent to including both `e` and `edit`. The SyntaxHighligher doesn't understand this convention, so I had to expand all of these abbreviations into longhand. I wrote a [little ruby script][expander] that does this for me. Here's the gist of it:

<pre class="brush: ruby">
list = ['abc[lear]', 'argu[ment]', 'bel[owright]']
pattern = /(\w+)(\[(\w+)\])?/
output = []
list.each do |token|
  if token =~ pattern
    output &lt;&lt; $1 if $1.length &gt; 1
    if $3
      output &lt;&lt; $1 + $3
    end
  end
end
puts output.join(' ')
</pre>

Since I first created the Vimscript brush, I have occasionally pruned the list of keywords. Although it might be handy that you can type `:e` instead of spelling out `:edit` in full, I don't really want the letter `e` to be considered a *keyword*. 

This is a matter of taste, but I have come accross other situations where the shorthand actually caused problems. For example, if I want to include an angle bracket character (common in Vimscript when creating keymappings), I have to encode the `<` character to it's HTML entity `&lt;`. I found that the syntax highlighter would identify `lt` as a keyword (being shorthand for `ltag`), breaking the HTML entity up into something like `&<code class="keyword">lt</code>;`. As a result, the angle bracket would instead appear spelled out as an HTML entity, with `lt` highlighted as a keyword!

This makes a good case for removing `lt` from the list of keywords. It is quite possible that there are other keywords in the list which could cause similar problems, as yet unencountered. If you try out the Vimscript brush and discover any of these problems, please let me know. Or better still, fork the project, fix it, and send me a pull request on Github.


[blackboard]: http://github.com/nelstrom/SyntaxHighlighter/blob/master/styles/shThemeBlackboard.css
[vimscript]: http://github.com/nelstrom/SyntaxHighlighter/blob/master/scripts/shBrushVimscript.js
[expander]: http://github.com/nelstrom/SyntaxHighlighter/blob/master/expander.rb
