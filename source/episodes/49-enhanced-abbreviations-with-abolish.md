--- 
:title: Enhanced abbreviations with :Abolish
:date: 2013/04/29
:poster: /images/posters/abolish-abbrev.png
:flattr_id: "1303220"
:duration: 189
:ogg: 
  :url: http://media.vimcasts.org/videos/49/abolish-abbreviate.ogv
  :size: 4705804
:quicktime: 
  :url: http://media.vimcasts.org/videos/49/abolish-abbreviate.m4v
  :size: 8399568

---

Vim's built-in abbreviation feature is handy if you want to auto-correct words that you frequently misspell, but it requires a lot of setup. The `:Abolish` command makes it easy to generate abbreviations that will correct multiple forms of the same word.

*This is the final of a three-part series on Tim Popeâ€™s [abolish] plugin.*

[abolish]: https://github.com/tpope/vim-abolish

READMORE

<r:snippet name="announcement"/>

Vim's built-in [abbreviations][ab] feature can provide auto-correct functionality. For example, we could make Vim auto-correct 'colour' (the British spelling) to 'color' (the American spelling) by running this command:

    :iabbrev colour color

However, abbreviations are case sensitive, so if we wanted to trigger the auto-correction on 'Colour', we'd have to create another abbreviation. The same goes for 'COLOUR', as well as for 'colours', 'coloured', 'colouring', and so on.

The abolish plugin, by Tim Pope, provides a solution for this. It includes a smart command called `:Abolish`, which has a similar form to the built-in `iabbrev` command.

This single command:

    :Abolish {hon,col}our{,s,ed,ing} {}or{}

Generates all of these abbreviations in one go:

    :iabbrev  honours     honors
    :iabbrev  honoured    honored
    :iabbrev  HONOURS     HONORS
    :iabbrev  Honoured    Honored
    :iabbrev  HONOUR      HONOR
    :iabbrev  honouring   honoring
    :iabbrev  Honours     Honors
    :iabbrev  honour      honor
    :iabbrev  HONOURED    HONORED
    :iabbrev  Honour      Honor
    :iabbrev  HONOURING   HONORING
    :iabbrev  Honouring   Honoring
    :iabbrev  COLOURING   COLORING
    :iabbrev  colouring   coloring
    :iabbrev  COLOURED    COLORED
    :iabbrev  Colouring   Coloring
    :iabbrev  Coloured    Colored
    :iabbrev  coloured    colored
    :iabbrev  COLOURS     COLORS
    :iabbrev  Colours     Colors
    :iabbrev  colours     colors
    :iabbrev  Colour      Color
    :iabbrev  colour      color
    :iabbrev  COLOUR      COLOR


The `:Abolish` command is really handy if you want to auto-correct the words that you frequently mis-spell. Check out [Tim Pope's abbreviations][tpope] for ideas.

I've created an [Americanize][] plugin, which uses the `:Abolish` command to auto-"correct" lots of British words to their American equivalents.

### Further reading

* [`:help Abbreviations`][ab]
* [abolish][] on github
* [Americanize][] on github
* [Tim Pope's abbreviations][tpope]

[ab]: http://vimdoc.sourceforge.net/htmldoc/map.html#Abbreviations
[abolish]: https://github.com/tpope/vim-abolish
[Americanize]: https://github.com/nelstrom/vim-americanize
[tpope]: https://github.com/tpope/tpope/blob/master/.vim/after/plugin/abolish.vim
