--- 
:title: Using the changelist and jumplist
:date: 2010/03/23
:poster: /images/posters/vimlists.png
:flattr_id: "31933"
:duration: 201
:number: 11
:ogg: 
  :url: http://media.vimcasts.org/videos/11/changelist_and_jumplist.ogv
  :size: 6286432
:quicktime: 
  :url: http://media.vimcasts.org/videos/11/changelist_and_jumplist.m4v
  :size: 5406874

---

This episode introduces the changelist and jumplist, demonstrating a couple of situations where they are useful. 


READMORE

<r:snippet name="announcement"/>

### The Changelist

The changelist remembers the position of every change that can be undone. You can move back and forwards through the changelist using the commands:

    g;
    g,

You can view the contents of the changelist by running the command:

    :changes

### The Jumplist

Vim also maintains a jumplist, remembering each position to which the cursor jumped, rather than scrolled. You can move backwards and forwards through the jumplist with the commands:

    ctrl-O
    ctrl-I

You can view the contents of the jumplist by issuing the command:

    :jumps

When you are browsing Vim's documentation, you can follow the link under the cursor with the command:

    ctrl-]


### Further reading ###

* [`:help changelist`][changelist]
* [`:help :changes`][changes]
* [`:help jumplist`][jumplist]
* [`:help :jumps`][jumps]
* [`:help jump-motions`][jumpmotions]


[changelist]: http://vimdoc.sourceforge.net/htmldoc/motion.html#changelist
[changes]: http://vimdoc.sourceforge.net/htmldoc/motion.html#:changes
[jumplist]: http://vimdoc.sourceforge.net/htmldoc/motion.html#jumplist
[jumps]: http://vimdoc.sourceforge.net/htmldoc/motion.html#:jumps
[jumpmotions]: http://vimdoc.sourceforge.net/htmldoc/motion.html#jump-motions
