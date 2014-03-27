--- 
:title: Whitespace preferences and filetypes
:date: 2010/01/17
:poster: /images/posters/whitespace_preferences_and_filetypes.png
:flattr_id: "31925"
:duration: 209
:number: 3
:tags: whitespace, autocommands, filetypes
---

Different file types may require particular whitespace settings. For example, YAML files must be indented using spaces, whereas makefiles require indentation with tabs. These preferences can be specified by hooking into the `FileType` event with an autocommand.


READMORE


Put the following in your `.vimrc` file:

```viml
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
  
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif
```

###Further reading

* [`:help :autocmd`][autocmd]
* [`:help FileType`][filetype]
* [`:help :setlocal`][setlocal]
* [`:help :setfiletype`][setfiletype]
* [`:help BufNewFile`][newfile]
* [`:help BufRead`][read]


[autocmd]: http://vimdoc.sourceforge.net/htmldoc/autocmd.html#:autocmd
[filetype]: http://vimdoc.sourceforge.net/htmldoc/autocmd.html#FileType
[setlocal]: http://vimdoc.sourceforge.net/htmldoc/options.html#:setlocal
[setfiletype]: http://vimdoc.sourceforge.net/htmldoc/options.html#:setfiletype
[newfile]: http://vimdoc.sourceforge.net/htmldoc/autocmd.html#BufNewFile
[read]: http://vimdoc.sourceforge.net/htmldoc/autocmd.html#BufRead
