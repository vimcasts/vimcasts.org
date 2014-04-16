--- 
:title: Soft wrapping text
:date: 2010/04/20
:poster: /images/posters/soft_wrapping_text.png
:flattr_id: "31941"
:duration: 294
:number: 16
:tags: plaintext, Formatting text
---

Long lines of text can be wrapped if they don't fit inside the window. By default, Vim will happily split in the middle of a word. This episode demonstrates how to use the 'linebreak' option to make Vim break lines without breaking words.


READMORE


If you want to make Vim wrap long lines to fit in the window, you first have to enable `:set wrap`. By default Vim will break lines at exactly the width of the window, which causes some words to be split across two lines. To prevent this from happening, you can enable `:set linebreak`. 

The `linebreak` setting will not work when the `list` setting is enabled. So if you find that enabling `linebreak` does not produce the desired effect, try running `:set nolist`. To be sure, you can run the following command:

```viml
:set wrap linebreak nolist
```

Rather than having to ensure that 3 separate options are configured correctly, I would prefer if I could just issue the command `:Wrap`. This can be achieved by putting the following in your .vimrc file:

```viml
command! -nargs=* Wrap set wrap linebreak nolist
```

Moving around through wrapped lines
-----------------------------------

Unlike many text editing environments, Vim makes a distinction between displayed lines, and numbered lines.  When `wrap` is enabled, each numbered line might be split across more than one display lines. The `k` and `j` keys move up and down by numbered lines. If you want to move the cursor up and down by display lines instead, you can use the commands `gk` and `gj` instead.

Hitting two keys in quick succession feels slow compared to pressing a single key whilst holding down a modifier key. I have the following in my .vimrc file:

```viml
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^
```
    
On the mac, this allows me to use `j`, `k`, `$`, `0` and `^` on display lines by holding down the command key.

Knowing where you are
---------------------

Without any visual clues, it could be hard to tell whether you are looking at display lines or numbered lines. The simplest way to tell is to switch line numbering on:

```viml
:set number
```

If you prefer not to show line numbers, there is another way. The `showbreak` option can be set to a character which will lead each display line after the first one. It can be set as follows:

```viml
:set showbreak=â€¦
```

To insert the elipsis, press `ctrl-vu` followed by the [numeric code for elipsis][elipsis]: `2026`. [Episode 1](http://vimcasts.org/e/1) covers unicode character insertion in a little more detail.

###Further reading

* [`:help linebreak`][linebreak]
* [`:help wrap`][wrap]
* [`:help showbreak`][showbreak]
* [`:help gj`][gj]

[linebreak]: http://vimdoc.sourceforge.net/htmldoc/options.html#'linebreak'
[showbreak]: http://vimdoc.sourceforge.net/htmldoc/options.html#'showbreak'
[wrap]: http://vimdoc.sourceforge.net/htmldoc/options.html#'wrap'
[gj]: http://vimdoc.sourceforge.net/htmldoc/motion.html#gj
[elipsis]: http://www.fileformat.info/info/unicode/char/2026/index.htm 

