--- 
:title: A text-object for ruby blocks
:date: 2010/12/27
:tags: text-objects, ruby, plugins
---

Ever since learning about Vim's [text-objects][] I have wished that there was a way of selecting blocks in ruby code. Well, now there is. Today I am releasing a plugin that creates [a custom text object for selecting ruby blocks][rubyblock]. Merry Christmas!

[text-objects]: http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
[rubyblock]: http://www.vim.org/scripts/script.php?script_id=3382



READMORE

###Usage

In ruby, a block is always closed with the `end` keyword. Ruby blocks may be opened using one of several keywords, including `module`, `class`, `def` `if` and `do`. The [rubyblock][textobj-rubyblock] plugin is aware of each of these.

In the example image below, suppose your cursor was positioned on the word `def`. Typing `var` would enable visual mode, selecting _all_ of the method definition. 

![The 'var' text-object selects all of the current ruby block](/images/blog/rubyblock-all.png)

Whereas if you typed `vir`, everything _inside_ of the method definition would be selected:

![The 'vir' text-object selects inside of the current ruby block](/images/blog/rubyblock-inner.png)

If you make a visual selection, you can expand it to encompass the outer ruby block by pressing `ar`, or you can contract your selection by pressing `ir`. You can repeat this as many times as you like. The image below begins with the innermost ruby block selected. By pressing `ar` again and again, the selection expands until it encompasses all of the outermost block. If you press `ir`, you can back up the other way, contracting the selection towards inner blocks.

![You can expand or contract your selection by repeating 'ar' and 'ir' commands](/images/blog/rubyblock-scissorkick.png)

###Installation

If you like to [keep your plugins under version control with pathogen][pathogen], then you will want to clone the [textobj-user][kana-git] and [textobj-rubyblock][ruby-git] plugins from github.

If you're old-school, you can get the [textobj-user][] and [textobj-rubyblock][] plugins from [vim.org][].

Note that the rubyblock plugin currently requires that the [matchit.vim][] plugin is enabled. This can be done by adding the following line to your vimrc:

```viml
runtime macros/matchit.vim
```

Also note, that there is a plugin called ruby-matchit, which calls itself 'matchit for ruby'. If you have this installed, it may interfere with the operation of the rubyblock plugin. Also, matchit.vim supports ruby now (which was not the case when ruby-matchit was written), so there's no need to install them both.

Morgan Prior took the time to explain [how to install the rubyblock plugin][morgan] on his blog, so go read that if my instructions are too brief. Thanks Morgan!

###Issues

If you notice any unexpected behaviour, I would appreciate if you could report it on the [github issue tracker][issues] for this project.

###Thanks

I never thought I had the vimscript chops to put this plugin together, but the [textobj-user][] framework made it possible. So I'd like to say a big thankyou to [Kana][] for his excellent work. 

[Kana]: http://whileimautomaton.net/
[pathogen]: http://vimcasts.org/e/27
[textobj-user]: http://www.vim.org/scripts/script.php?script_id=2100
[kana-git]: https://github.com/kana/vim-textobj-user
[textobj-rubyblock]: http://www.vim.org/scripts/script.php?script_id=3382
[ruby-git]: https://github.com/nelstrom/vim-textobj-rubyblock
[vim.org]: http://www.vim.org/scripts/index.php
[matchit.vim]: http://www.vim.org/scripts/script.php?script_id=39
[issues]: https://github.com/nelstrom/vim-textobj-rubyblock/issues
[morgan]: http://amaras-tech.co.uk/people/morgan/article/84
