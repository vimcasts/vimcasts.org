--- 
:title: Running Vim within IRB
:date: 2010/05/16
:poster: /images/posters/irb_and_vim.png
:flattr_id: "31945"
:duration: 275
:number: 20
:tags: ruby, interactive
---

If you work with ruby you will know that the interactive ruby shell, or 'IRB' for short, is a useful sketchpad for coding. But the command line interface of IRB can feel quite limiting in comparison with the power of your text editor. In this episode, I'm going to demonstrate how you can get the best of both worlds, by loading Vim from inside IRB.


READMORE


IRB is great for trying out one liners, but if you need to sketch longer
blocks of ruby, it soon falls down. 

In his [Utility Belt gem][utilitybelt], [Giles Bowkett][gilescast] has
collected a grab-bag of tricks and techniques for IRB, the highlight of
which is the ability to [interactively edit code in your text
editor][origins]. The Utility Belt gem hasn't been updated in a little
while, but the interactive editor has continued to evolve, thanks to
[Jan Berkel][evolution] and with help from [Charles Nutter][nutter].

Installation
------------

Install the [interactive editor gem][editor] by running this at the
command line:

    gem install interactive_editor

Create an `~/.irbrc` file if you don't already have one, then paste the
following into it:

```ruby
require 'rubygems'
require 'interactive_editor'
```

Note that the utility belt gem also includes an interactive editor, but
it is currently out of date. If you require both `interactive_editor`
and `utility_belt` gems in your .irbrc file, there may be some conflict
between them.

Vim: restore cursor position and highlight syntax
-------------------------------------------------

To get the most from this technique, you will want to ensure that you
have enabled filetype detection and syntax highlighting in Vim.
Additionally, it is helpful to have Vim [restore the cursor
position][restore_cursor] to where you left it. The following snippet of
Vimscript takes care of these.

```viml
if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on

  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif
if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif
```

Note that the [example vimrc file][example_vimrc] that comes with Vim
includes all of the above, so don't paste this into your vimrc without
first checking if you already have this functionality.

[origins]: http://gilesbowkett.blogspot.com/2007/10/use-vi-or-any-text-editor-from-within.html
[gilescast]: http://gilesbowkett.blogspot.com/2008/11/vi-in-irb-screencasting-fail.html
[evolution]: http://zegoggl.es/2009/04/integrating-vim-and-irb.html
[nutter]: http://blog.headius.com/
[utilitybelt]: http://utilitybelt.rubyforge.org/
[example_vimrc]: http://vim.cybermirror.org/runtime/vimrc_example.vim
[restore_cursor]: http://vimdoc.sourceforge.net/htmldoc/usr_05.html#restore-cursor
[editor]: http://github.com/jberkel/interactive_editor

