--- 
:title: Creating repeatable mappings with repeat.vim
:date: 2014/01/21
:poster: /images/posters/repeatable-mappings.png
:flattr_id: ""
:duration: 273
:number: 61
:ogg: 
  :url: http://media.vimcasts.org/videos/61/map-with-repeat.ogv
  :size: 7103130
:quicktime: 
  :url: http://media.vimcasts.org/videos/61/map-with-repeat.m4v
  :size: 9958244
:tags: repeat, mappings, vimscript
---

The dot command is my all-time favorite Vim trick: it tells Vim to repeat the last change. But the dot command tends not to work well with user-defined mappings. In this episode, we'll use repeat.vim to set up a simple mapping so that it can be repeated using the dot command.

READMORE

<r:snippet name="announcement"/>
 
The README for [repeat.vim][r] begins:

> If you've ever tried using the `.` command after a plugin map, you were likely disappointed to discover it only repeated the last native command inside that map, rather than the map as a whole. That disappointment ends today. Repeat.vim remaps `.` in a way that plugins can tap into it.

I've often felt this sense of disappointment when using Vim's `xp` commands to transpose two characters. I'd like to be able to use the dot command to repeat `xp`, but it only repeats the `p` command, which is the *last native command*. Let's create a custom `cp` mapping that transposes two characters in a way that can be repeated using the `.` command.

### Constructing a repeatable mapping

Usually, Vim's mappings follow this general format:

    :map LHS RHS

This instructs Vim to execute the keys on the right-hand side (RHS) of the expression whenever the user presses the keys on the left-hand side (LHS). Alternatively, we can create a *named mapping* by using the [`<Plug>`][plug] key on the LHS of the expression. Named mappings can't be executed directly by the user, but they can be referenced by other mappings (see [`:help using-<Plug>`][using-plug]). For example, this pair of mappings:

    nmap <Plug>TransposeCharacters xp
    nmap cp <Plug>TransposeCharacters

Has the same effect as this single mapping:

    nmap cp xp

That is, when the user presses `cp`, Vim executes the `x` command followed by the `p` command. We can use the `repeat#set()` function (supplied by repeat.vim) to tell Vim to invoke our named mapping when the dot command is used. Here's the complete mapping:

    nnoremap <silent> <Plug>TransposeCharacters xp
    \:call repeat#set("\<Plug>TransposeCharacters")<CR>
    nmap cp <Plug>TransposeCharacters

Note that the line beginning with `\` is a continuation of the previous line. When the user presses `cp`, Vim executes the `<Plug>TransposeCharacters` named mapping. That mapping executes the Normal commands `x` then `p`, then runs `:call repeat#set("\<Plug>TransposeCharacters")`, which instructs the dot command to execute the named mapping.

### Further reading

* [`:h .`][dot]
* [repeat.vim][r] by tpope
* [`:h <Plug>`][plug]
* [`:h using-<Plug>`][using-plug]

[r]: https://github.com/tpope/vim-repeat
[dot]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#.
[plug]: http://vimdoc.sourceforge.net/htmldoc/map.html#<Plug>
[using-plug]: http://vimdoc.sourceforge.net/htmldoc/usr_41.html#using-<Plug>
