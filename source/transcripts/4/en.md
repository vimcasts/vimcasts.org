Convert between tabs with spaces
--------------------------------

It is sometimes useful to be able to convert between tabs and spaces
for indentation. If you collborate on a project without agreeing on a
convention for indentation, there's a good chance that at some point
you'll see something like this.

It looks as though this file hasn't been indented correctly. If I reveal
the invisible characters, you can see that one block of text has been
indented using spaces, whereas the rest of the file uses tab
characters.

Now if I change the value of `tabstop` from 4 to 2, everything appears
to snap into place.

To avoid this kind of confusion, lets fix the indentation style to use
tab characters throughout the file.

First, make sure that `expandtab` is switched off, by running `:set
noexpandtab`. Then run the command:

    :retab!

This inserts tab characters to replace spaces of an equivalent width
throughout the entire file.

Now if I enable `expandtab` and run the command again, it converts all
the tabs to back to spaces.

If I don't want to affect the entire file, I can make a visual
selection first, then run `:retab!`, and it will only affect the
selected lines.

Strip trailing characters
-------------------------

Trailing spaces at the end of a line are another of those issues that
divide programmers. While it drives some of us crazy, others just
don't care or even notice, perhaps.

In Vim, you can easily strip trailing whitespace from a file using a
substitute command:

    :%s/\s\+$//e

This breaks down as follows:

* The colon enters command mode
* The `s` is short for the substitute command
* The percent sign specifies that the entire file should be affected
  (not just the current line).
* the first two forward slashes delimit the search pattern
* `\s` stands for a whitespace character, and the escaped plus sign
  (\+) indicates that one or more spaces should be matched, preceding a
  line end (the dollar sign)
* the last two slashes delimit the replacement string. Here, it is blank,
  so it replaces trailing whitespace with nothing.
* The `e` flag suppresses an error message if no matches are found.

This is a lot to type, so you might want to try mapping it to a
shortcut. You could put the following in your .vimrc, which maps this
to the `F5` key:

    :nnoremap <F5> :%s/\s\+$//e<CR>

But there are a couple of side-effects to running this command.  One
is that your cursor will be moved from its current position to the
last line where the substitution was made. Another is that the last
item in your search history is set to the pattern of whitespace at the
end of a line. If you have search highlighting enabled, then you will
see spaces highlighted momentarily as you type, which can be a little
distracting. Here is a function that gets around these problems.

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

If you include this in your .vimrc file, you can then map it to a
key like this:

    nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

It is also possible to use an autocommand to call this function just
before saving a file. Be aware that in some filetypes, spaces at the
end of a line can have meaning, so stripping them could potentially
break the file. For example, in this snippet of vimscript, the
space at the end of the line is intentional:

    set listchars=eol:¬,tab:▸\ 

If you choose to enable this autocommand, I would recommend providing
a whitelist of filetypes which you are sure won't be broken by
stripping trailing spaces. This example causes the autocommand to be
fired before saving python and javascript files only.

    autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

Use this as a template, and add other filetypes to suit your needs.

Strip blank lines
-----------------

Sometimes you'll open a file, and find that it has too many extraneous
blank lines, making it difficult to read. You can quickly strip out
all empty lines with this command:

    :g/^$/d

This breaks down as follows:

* `:g` creates a global command, that is, one that will opperate on the
  entire file.
* the forward slashes delimit a pattern to search for
  in this case, the caret-dollar pattern matches a line beginning
  followed immediatly by a line-end. That is: a blank line.
* the part following the pattern is an Ex command to be executed on all
  matching lines. 
* in this case, the `d` command deletes the line
