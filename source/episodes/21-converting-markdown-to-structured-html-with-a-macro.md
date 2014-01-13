--- 
:title: Converting markdown to structured HTML with a macro
:date: 2010/06/02
:poster: /images/posters/markdown_macro.png
:flattr_id: "31946"
:duration: 565
:number: 21
:ogg: 
  :url: http://media.vimcasts.org/videos/21/markdown_macro.ogv
  :size: 14625008
:quicktime: 
  :url: http://media.vimcasts.org/videos/21/markdown_macro.m4v
  :size: 20061622

---

Recording your keystrokes as a macro can be a great timesaver, but you have to be careful that you use commands in such a way that they can be reused. In this episode, I construct a fairly complex macro to build a structural HTML document from markdown.


READMORE

<r:snippet name="announcement"/>

The demonstration in this video uses a range of techniques to construct a
macro that can be replayed reliably, including text objects, the surround
plugin, using registers as a clipboard, and for storing keystrokes (macros).
These are summarized below.

If you would like to try building this macro for yourself, you can download
the source files:

* [HTML template][template]
* [Markdown source][source]

### Moving around ###

If you need to move around whilst recording a macro, it is best to do so in
such a way that it can be replayed in another context. In this demonstration,
I move the cursor by searching for a pattern that delimits each region of the
document that I need to edit. In particular, I search for the heading using
the command:

    /^#\d\d

This matches a Markdown style `h1`.

To return my cursor to the navigation list, I search backwards for the closing
`</ol>` tag:

    ?\/ol

There are a couple times when I need to add an attribute to an HTML tag. In
both cases, my cursor is positioned on the opening angle-bracket, so I use the
`%` key to jump to the closing angle-bracket before entering insert mode.

### Making a selection with text-objects ###

When selecting a paragraph of text, I need to use a command that will work
when the macro is replayed on different length paragraphs. I can do this using
the text object:

    Vip

A similar command comes in handy later, when I need to select the text inside
an HTML tag:
  
    vit

### Adding opening and closing tags with the surround plugin ###

The [surround.vim][s] plugin makes it really easy to wrap a selection with
opening and closing tags. When a visual selection has been made, you can
execute a command such as:

    s<li>

Which will prepend `<li>` and append `</li>` to the selected region. Note that
if your selection was made in visual character mode, the opening and closing
tags will be applied directly before and after the selection. Whereas if your
selection was made in visual line mode, the surrounding tags will each get a
new line of their own.

### Using registers ###

In Vim, each of the letters **a** through **z** can be used as a register. In
this demonstration I use registers in two ways:

* as a clipboard (for copy/paste operations)
* for capturing and replaying a sequence of commands (a macro)

### Further reading ###

* [The surround plugin][s]
* [:help text-objects][to]
* [:help q][record]

[s]: http://www.vim.org/scripts/script.php?script_id=1697
[to]: http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
[record]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#q
[template]: http://vimcasts.org/episodes/converting-markdown-to-structured-html-with-a-macro/template.html
[source]: http://vimcasts.org/episodes/converting-markdown-to-structured-html-with-a-macro/pecha-kucha-script.md
