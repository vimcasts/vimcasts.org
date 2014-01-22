Show invisibles 
===============

TextMate has an option to 'Show invisibles', which lets you see tab
and end-of-line characters. When this is enabled, tab characters
appear as a small triangle (▸), and end of lines appear as a 'not
sign' (¬). This is helpful for distinguishing between tabs and spaces,
and for revealing trailing spaces at the end of a line.

In Vim, we can display invisible characters by enabling `:set list`.
You can hide these characters again by running `:set nolist`, or you
can toggle between showing and hiding them by running `:set list!`. If
you want to be able to do this quickly, you might like to map the
toggling command to something more convenient. Try putting the
following in your .vimrc:

    nmap <leader>l :set list!<CR>

Now you can toggle between showing and hiding invisible characters
with `\l` (backslash-L). [Note that if you have set your mapleader to
a value other than backslash, you will have to use that instead].

Customize symbols 
-----------------

By default, the tab character is represented literally as `^I`, and
end-of-lines are represented by a dollar sign. 

We can customise the symbols used to represent invisible characters by
changing the `listchars` setting. If you want to use the same symbols
as TextMate does, put the following into your .vimrc:

    set listchars=tab:▸\ ,eol:¬

If you like, you can customise other invisible characters besides tabs
and end-of-lines. For more information, get help on listchars:

    :help listchars

Colortheme symbols
------------------

Depending on the colorscheme you are using, you may want to change the
colors of tab and end-of-lines symbols. I prefer to make them close in
color to the background, so that they are only just visible, and not
too distracting. The syntax keyword for an end-of-line is "NonText",
and for tab characters it is "SpecialKey". I have added these lines to
my prefered colorscheme file:

    "Invisible character colors 
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

Aside on inserting literal characters
-------------------------------------

You shouldn't have any problems if you copy and paste the `listchars`
setting from the shownotes into your .vimrc file. But just in case, 
here is a method for inserting any Unicode character directly in Vim.

In insert mode, press ctrl-V, then type u followed by the numeric 
code for the symbol you want to insert. e.g.:

    ctrl-v u00ac inserts '¬' (the not sign)
    ctrl-v u25b8 inserts '▸' (the triangle symbol)

You can also insert a tab character in insert mode by typing:

    ctrl-v ctrl-i

As you can see, the default `^I` symbol that Vim uses to represent a
tab character is the same as the literal key sequence that we can use
to insert this character. So if you've ever wondered why `:set list` 
showed tab characters by default as 'ctrl-I', now you know: that's how
Vim represents tab characters internally. 
