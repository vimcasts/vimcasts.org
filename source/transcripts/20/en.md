If you work with ruby, you probably know that the interactive ruby
console, or 'IRB' for short, is a useful sketchpad for coding. But the
command line interface of IRB can feel quite limiting in comparison with
the power of your text editor. In this episode, I'm going to demonstrate
how you can get the best of both worlds, by loading Vim from inside IRB.

* Limitations of IRB - multi line, history
* Pimp irbrc
* Demonstrate jumping into Vim, :wq to execute, vi to return
* .vimrc helpers: syntax on
* Deficiency: cursor position
* .vimrc helper: restore cursor position
* save file to file system
* reload it from file system

> Write a program that prints the numbers from 1 to 100. But for
> multiples of three print "Fizz" instead of the number and for the
> multiples of five print "Buzz". For numbers which are multiples of
> both three and five print "FizzBuzz".
 
IRB limitations
---------------

I'm going to begin by demonstrating the limitations of IRB with a quick
example. Suppose I want to sketch out a loop, with an if else block
inside. I type each line, then hit enter. When I close the block, the
code is executed immediately. That instant feedback is what makes IRB
such a useful tool. But what if I wanted to change a single line in this
block? I would have to enter every line all over again. 

    (1..15).each do |i|
      if i%3==0
        puts "fizz"
      elsif i%5==0
        puts "buzz"
      else
        puts i
      end
    end
    

IRBRC
-----

Just as you can customise Vim with a dot-vimrc file, you can customize
your IRB session with a dot-irbrc file. In his Utility Belt gem, Giles
Bowkett has collected a grab-bag of tricks and techniques for IRB, the
highlight of which is the ability to interactively edit code in your
text editor. The Utility Belt gem hasn't been updated in a little while,
but the interactive editor has continued to evolve, thanks to [Jan
Berkel][evolution] and with help from Charles Nutter. 

You can find instructions on how to enable the interactive editor
functionality in the show notes for this episode. 

Demonstrate IRB to vi
---------------------

Having installed the interactive editor, my IRB session is enhanced with
a `vi` method. If I launch IRB I can type `vi` followed by enter, and it
opens a new Vim session. When I save the file and exit Vim, the contents
of the buffer are evaluated in IRB. Now when I jump back into Vim, it
reopens the temporary file with the same contents as before.

This makes it much easier to do iterative development in IRB. If I have
several lines of code, and I want to modify just one of them, I only
need to change that one line of code, save the file, and the whole thing
will be evaluated again.

Get syntax highlighting
-----------------------

Note that the temporary file has the extension `.rb`. This means that
Vim can detect the filetype, and enable the appropriate syntax
highlighting. To benefit from this, there are a couple of things you
should include in your vimrc.


    if has("autocmd")
      " Enable filetype detection
      filetype plugin indent on
    endif
    if &t_Co > 2 || has("gui_running")
      " Enable syntax highlighting
      syntax on
    endif

This enables filetype detection and syntax highlighting. You might
consider the conditional blocks as optional, but they do ensure that
your vimrc remains portable, by only enabling this functionality if it
is available.

You may already have these enabled, so be sure to check before pasting
them into your vimrc file.

Having made these changes, I can now launch Vim from IRB and have my
ruby code syntax highlighted.

Restore cursor position
-----------------------

At the moment, my cursor position is reset to line 1 each time I launch
Vim. It would be nice if the cursor was restored to its last position
when I relaunched Vim. This can be achieved by adding a short snippet of
Vimscript to the vimrc file. 

    if has("autocmd")
      autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    endif

Now, when I leave Vim and come back to it, the cursor is restored to its
old position.

Save and reload your work
-------------------------

If you jump in to Vim from IRB, and decide that you don't want to lose
your work, you can save the file to disc by passing a file name to the
`:w` command. Now if I quit Vim and exit IRB, you can see the file in my
current directory.

When I launch IRB again, I can pass the name of this file as an argument
to the `vi` command, and continue with my work.

Note that whilst Vim is open, you can open other files, but IRB will
only execute the contents of the file which was present 

Under the hood
--------------

Here's a quick overview of what's happening under the hood:

    file = File.open("mytempfile", "w")
    system("vi", file.path)
    eval(file.read)

Calling `vi` from IRB creates a temporary file, then launches Vim to
edit that file. When you quit Vim, ruby evalutates the contents of the
file.

When you call `vi` from IRB, a temporary file is created, then Vim is
launched to edit that temporary file. When you quit Vim, ruby evalutates
the contents of the file.
