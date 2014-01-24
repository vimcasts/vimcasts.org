--- 
:title: Converting HAML to ERB with Vim macros
:date: 2010/07/08
:poster: /images/posters/haml_to_erb.png
:flattr_id: "33029"
:duration: 456
:number: 23
:ogg: 
  :url: http://media.vimcasts.org/videos/23/haml_to_erb.ogv
  :size: 11656496
:quicktime: 
  :url: http://media.vimcasts.org/videos/23/haml_to_erb.m4v
  :size: 16722383

---

HAML and ERB are two commonly used ruby templating languages. You may have a strong preference for one or the other, but it's not always up to you which one you use. I was recently asked to convert several HAML files to ERB format. In this episode, I will demonstrate a couple of Vim macros that helped make short work of the task. 
 

READMORE


This is not intended to be a complete solution for converting haml files to erb. Indeed, there may be better ways to approach this problem (and if you know of any, I'd be glad to hear about them in the comments below). The point of this demonstration is to showcase some of the things that you can acheive using Vim's macros. You may encounter other scenarios where these techniques come in useful.

###Single line conversion

For a haml one-liner the conversion to ERB is straightforward. The following steps were taken:

* `qp` to record keystrokes into the **p** register
* `I` to insert "&lt;%" at the beginning of the line
* `A` to append " %&gt;" at the end of the line
* `q` to finish recording the macro

I then searched for the pattern `^\s*=` to jump to the next one-liner. The macro can be replayed by pressing `@p`. Subsequent one-liners can be converted by running `n@@` - `n` jumps to the next match, and `@@` replays the macro that was most recently played.

###Multi-line conversion

Whereas haml uses significant whitespace to delimit blocks (in a similar fashion to [Python][p]), erb uses the `end` keyword (like tradtional [Ruby][r]). I created a macro that allows me to visually select a region that needs to be terminated with an `end` keyword. Playing the macro converts the first line to erb by wrapping it in `<%- %>` delimitters, then appends the `<% end %>` keyword after the block.

The macro works by setting marks at the top and bottom of the visual selection. This allows me to jump between the two regions that need to be edited. You can set a mark by pressing `m` followed by a letter. I chose to use the letter 't' for the top mark, and 'b' for the bottom mark because I find these easy to remember. You can use whatever mnemonic suits you. Having set the marks, you can then jump to them by typing `'t`. That is, single-quote followed by the letter of the mark you want to jump to.

###Auto-indentation

When I open an ERB file, Vim detects the filetype from the file extension and sets the auto indentation accordingly. In this case, I have a HAML file with the ERB extension. This is going to confuse Vim's automatic indentation, so I switched it off by running:

    :set indentexpr=

###Further reading

* [`:h q` - macros][q]
* [`:h m` - marks][m]

[p]: http://www.python.org/ 
[r]: http://ruby-lang.org/ 
[q]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#q
[m]: http://vimdoc.sourceforge.net/htmldoc/motion.html#m
