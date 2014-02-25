--- 
:title: An introduction to vspec
:date: 2013/06/17
:poster: /images/posters/vspec-intro.png
:flattr_id: "1496691"
:duration: 435
:number: 50
:tags: vimscript, testing, plugins
---

[Vspec][vspec] is a library that allows you to test-drive your Vimscript code. In this tutorial, we'll cover the basics: how to inspect the contents of a buffer, how to simulate the actions of a user, and how to invoke user-defined mappings.

[vspec]: https://github.com/kana/vim-vspec


READMORE


Vspec lets you write tests for you Vimscript code, following a format that resembles [rspec][]. We can use a `describe` block to specify a context, then wrap each individual test in an `it` block. Each of these blocks is closed with an `end` keyword, just like in ruby:

    describe 'vspec'
      it 'is inspired by rspec'
      end
    end

Check out Kana Natsuno's blog post for instructions on [how to set up a Vim plugin to be tested by vspec][setup].

### Sample code

Here's the vspec code that was demonstrated in the video:

    nnoremap x daw
    
    describe 'vspec'
    
      before
        new
        put! = 'Welcome to Vimcasts'
      end
    
      after
        close!
      end
    
      it 'can read the contents of the buffer'
        Expect getline(1) == "Welcome to Vimcasts"
      end
    
      it 'feels just like operating Vim!'
        normal gg$
        normal daw
        Expect getline(1) == 'Welcome to'
        Expect getreg('"') == ' Vimcasts'
      end
    
      it 'can exercise user-defined mappings'
        normal gg$
        normal x
        Expect getline(1) == 'Welcome to'
        Expect getreg('"') == ' Vimcasts'
      end
    
    end

### :normal Vs :normal!

In the demo, I used the [`:normal` command][normal]. It's worth noting that the `:normal!` command, when used with a trailing bang, will avoid user-defined mappings. That's useful if you want to invoke built-in functionality. For example, if we had used `:normal! x` in our vspec test, then it would have invoked [Vim's built-in `x` command][x], ignoring our custom mapping.

In [Learn Vimscript the Hard Way][lvsthw29], Steve Losh says "when writing Vim scripts you should always use normal!, and never use plain old normal". This is good advice when writing plugin functionality, but you can disregard it when writing vspec tests for that same plugin. If you want to test the functionality of a user-defined mapping, then `:normal` (without the bang) is the way to do it.

### Further reading

* [vspec on github][vspec]
* [Kana's introduction to vspec][setup]
* [Set up continuous integration for a Vim plugin using Travis][ci]
* [Learn Vimscript the Hard Way][lvsthw], by Steve Losh
* [`:help :put`][put]
* [`:help :normal`][normal]
* [`:help getline()`][getline]
* [`:help getreg()`][getreg]
* [`:help :new`][new]
* [`:help :close`][close]

[vspec]: https://github.com/kana/vim-vspec
[setup]: http://whileimautomaton.net/2013/02/13211500
[ci]: http://whileimautomaton.net/2013/02/08211255
[lvsthw]: http://learnvimscriptthehardway.stevelosh.com/
[lvsthw29]: http://learnvimscriptthehardway.stevelosh.com/chapters/29.html
[rspec]: https://github.com/rspec/rspec

[x]: http://vimdoc.sourceforge.net/htmldoc/change.html#x
[normal]: http://vimdoc.sourceforge.net/htmldoc/various.html#:normal
[getline]: http://vimdoc.sourceforge.net/htmldoc/eval.html#getline()
[getreg]: http://vimdoc.sourceforge.net/htmldoc/eval.html#getreg()
[new]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:new
[close]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:close
[put]: http://vimdoc.sourceforge.net/htmldoc/change.html#:put
