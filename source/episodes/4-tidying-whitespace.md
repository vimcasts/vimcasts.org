--- 
:title: Tidying whitespace
:date: 2010/01/24
:poster: /images/posters/tidying_whitespace.png
:flattr_id: "31926"
:duration: 273
:number: 4
:tags: whitespace, editing-text, customizations
---

This episode demonstrates a few techniques for tidying up whitespace.  First, it looks at how to convert between tabs and spaces. Then it shows how to strip trailing whitespace, and finally, how to remove blank lines from a file.


READMORE


###Converting between tabs and spaces


The command for converting between tabs and spaces is:

```viml
:retab!
```

More specifically, to convert tabs to spaces, run:

```viml
:set expandtab
:retab!
```

And to convert spaces to tabs, run:

```viml
:set noexpandtab
:retab!
```

###Strip trailing whitespace

Strip trailing spaces throughout an entire file by running this
substitution command:

```viml
:%s/\s\+$//e
```

This has a couple of side-effects: it moves your cursor, and sets the
last item in your search history to trailing whitespace. This function
gets around these problems:

```viml
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
```

Put it in your .vimrc file.

If you want to map this function to a key (e.g. F5), add this:

```viml
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
```

If you want to run this command automatically when a file is saved,
add this:

```viml
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
```

This example runs the autocommand on python and javascript files. Use
this as a template, and add other filetypes to suit your needs.

###Delete blank lines

You can delete all blank lines by running the following command:

```viml
:g/^$/d
```

###Further reading

* [`:help :g[lobal]`][global]
* [Remove unwanted spaces][trailing] (on the Vim tips wiki)
* [Automatically remove trailing spaces][autostrip] (on Stackoverflow.com)

###Updates

In the comments, [k00pa][gindent] has posted a method based on
`StripTrailingWhitespaces()`, which applies Vim's autoformat command to the
entire file then restores the cursor position. [Jonathan Palardy][refactor]
has recognised that `StripTrailingWhitespaces()`

> doesn’t do one thing, it does two (useful) things: saving the “state” and
> executing a command to remove the trailing whitespace.

He suggests refactoring the methods as follows:

```viml
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction 
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
```

I do like his choice of key mapping as well. The underscore key is not often
used, so makes for a good alternate `<leader>`. The `$` key is practically
synonymous with *end of line*, so it makes for a good mnemonic.

Jonathan goes into a little more detail on his blog. Go read: [Preserve: A
Vim function that keeps your state][refactor].

[global]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#:global
[trailing]: http://vim.wikia.com/wiki/Remove_unwanted_spaces
[autostrip]: http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
[gindent]: http://vimcasts.org/episodes/tidying-whitespace/?success#comment-37459247
[refactor]: http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
