Default wrapping unsatisfactory.

Fix it:

    :set wrap nolist linebreak

Demonstrate that `:set list` breaks the linebreak.
Demonstrate that `:set nowrap` breaks the linebreak.

Add to .vimrc:

    nmap <leader>l :set list!<CR>
    nmap <leader>w :set wrap!<CR>
    command! -nargs=* Wrap set wrap linebreak nolist


Moving around
-------------

Demonstrate that `j` and `k` don't work as you might expect. (Also `$`, `^` & `0`).

Expected behaviour from:

    gj
    gk
    g0
    g^
    g$

Also, cover `(` and `)` for moving back/forward through sentences. 

Demonstrate delete sentence, and swap sentence order.

Also demonstrate `C` on last sentence.

Also demonstrate `A` from anywhere in paragraph.

Knowing what's what
-------------------

Either:

    :set number

or...

    :set showbreak=>
    :set showbreak=…

To insert the elipsis: `ctrl-vu2026`.

If I switch line numbering off, it's actually very hard to tell whether you are looking at numbered lines or display lines. By default, the 'showbreak' setting is blank, but if you set this to a string then it will be printed at the beginning of each continued line. I like to use the unicode elipsis character. If you are working with softwrapped text, I would suggest that you enable either line numbering or showbreak to prevent confusion.

The information in this video is summarized in the accompanying shownotes.

Fix width
=========

Demonstrate TextMate's 'Soft Wrap' + 'Use window frame' option. Then show 'Soft Wrap' + 78 and so on. Not possible in Vim with soft wrap.

With vertical split, resize current width with:

    N ctrl-|

or

    :vertical resize N

Set the width of the window with:

    :set columns=80
