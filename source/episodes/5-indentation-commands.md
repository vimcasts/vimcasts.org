--- 
:title: Indentation commands
:date: 2010/02/08
:poster: /images/posters/indentation_commands.png
:flattr_id: "31927"
:duration: 341
:number: 5
:tags: Whitespace, Editing text
---

This episode covers the commands for shifting text left and right (`<` and `>`), and also goes over the auto indent command (`=`).


READMORE


To add TextMate's key mappings, put the following in your `.vimrc`:

```viml
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
```

###Further reading

* [:help shift-left-right][shifting]
* [:help =][autoformat]
* [:help text-objects][textobjects]
* [Formatting with an external program][autoformat]

[textobjects]: http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
[shifting]: http://vimdoc.sourceforge.net/htmldoc/change.html#shift-left-right
[autoformat]: http://vimdoc.sourceforge.net/htmldoc/change.html#=
[equalprg]: http://vim.runpaint.org/editing/formatting-with-an-external-program/
