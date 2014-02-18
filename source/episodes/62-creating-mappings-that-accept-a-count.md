--- 
:title: Creating mappings that accept a count
:date: 2014/02/06
:poster: /images/posters/mappings-with-count.png
:flattr_id: ""
:duration: 242
:number: 62
:ogg: 
  :url: http://media.vimcasts.org/videos/62/map-with-count.ogv
  :size: 6859558
:quicktime: 
  :url: http://media.vimcasts.org/videos/62/map-with-count.m4v
  :size: 10336771
:tags: count, mappings
:layout: episode
---

Lots of Vim's built-in Normal mode commands can be executed multiple times by prefixing them with a count. User-defined Normal mode mappings don't usually handle counts the way we might like them to. We'll explore a couple of techniques for making our custom mappings respond predictably to a count.

READMORE

<r:snippet name="announcement"/>

### Problem: make a mapping that handles counts

Suppose that we wanted to create a mapping so that pressing `Q` executed `n.`. We could start off with a simple mapping:

    nnoremap Q n.

Pressing `Q` now executes `n.`, giving us two keystrokes for the price of one. Nice! But if we try prefixing our new mapping with a count, something odd happens. For example, pressing `2Q` behaves as though we had pressed `2n.`. It would be more useful if `2Q` was equivalent to `n.n.`.

### Solution 1: execute a macro using the expression register

Let's revise our mapping to this:

    nnoremap Q @='n.'<CR>

Now, pressing `2Q` is equivalent to `n.n.`, `3Q` is equivalent to `n.n.n.`, and so on.

So how does it work? The `@` key tells Vim to execute a macro. Rather than using a [named register][quotea] we use the [expression register][@=], which lets us specify the contents in place. The characters inside of the quotes are interpreted as keystrokes, and the carriage return enters the string into the expression register.

You can find a short section about this technique in Vim's documentation by looking up [`:help map-examples`][map-examples].
There's also [an article on the VimWiki][wiki] explaining it.
For more on the expression register, check out episodes [56](/e/56) and [57](/e/57).

### Solution 2: use the :normal Ex command

This mapping also properly handles a count:

    nnoremap Q :normal n.<CR>

This uses the [`:normal`][:normal] Ex command. I would prefer to see this mapping in a vimrc than the previous example. To my eye it looks less cryptic.

### Further reading

* [`:h quote=`][@=]
* [`:h quote_alpha`][quotea]
* [`:h map-examples`][map-examples]
* [`:h :normal`][:normal]
* [`:h v:count`][v:count]
* [`:h v:count1`][v:count1]
* Vim wiki: [Supplying a count to a map][wiki]

[map-examples]: http://vimdoc.sourceforge.net/htmldoc/map.html#map-examples
[wiki]: http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)#Supplying_a_count_to_a_map
[@=]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote=
[quotea]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote_alpha
[v:count]: http://vimdoc.sourceforge.net/htmldoc/eval.html#v:count
[v:count1]: http://vimdoc.sourceforge.net/htmldoc/eval.html#v:count1
[:normal]: http://vimdoc.sourceforge.net/htmldoc/various.html#:norm
