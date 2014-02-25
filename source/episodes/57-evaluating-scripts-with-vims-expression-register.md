--- 
:title: Evaluating scripts with Vim's expression register
:date: 2013/10/21
:poster: /images/posters/expression-register-eval.png
:flattr_id: ""
:duration: 236
:number: 57
:tags: registers, expression-register, insert-mode, cmdline-mode
---

In [the previous lesson][previous] we learned how use the expression register to evaluate simple calculations. We can also call built-in and user-defined Vimscript functions, and thanks to the `system()` function, we can also fetch output from external scripts.

[previous]: /e/56

READMORE


### Calling functions from Vimscript standard library

In [the last lesson](/e/56), we saw how the expression register can be used for evaluating simple calculations, such as `2*21`. We can also use functions from the Vimscript standard library. For example, we could use the [`sqrt()`][sqrt()] function to calculate the square root of a number:

    :put =sqrt(81)

We can execute any Vimscript code at the expression register. So long as the expression returns a string (or something that can be converted to a string), then we can use the result. For a complete reference of the functions defined in Vim's standard library, look up [`:h function-list`][function-list].

### Calling user-defined functions

We're not limited to using functions defined in the Vimscript standard library. We can also evalute user-defined functions. For example, Vimscript has no simple way of generating a random number. We could hand-roll our own `Random()` function (this example is copied from [StackOverflow][rand()]):

    function! Random()
      return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
    endfunction

We could use this function at the expression register:

    :put =Random()

### Calling external scripts

The [`system()`][system()] function allows us to get the output from some external script. For example, if we're running Vim inside the Bash shell, we could use the built-in bash function `$RANDOM` to fetch a random number:

    :put =system('echo $RANDOM')

If we wanted some more complex behaviour, we could write a script using a language of our choice. For example, here's a tiny script written in Ruby, which uses the [faker library][faker] to generate fake credentials:

    require 'faker'
    name = [Faker::Name.first_name, Faker::Name.first_name].join(" ")
    print [name, Faker::Internet.email(name)].join(",")

We could run this script at the Bash shell like this:

    $ ruby fake-credentials.rb
    Lottie Walton,lottie.walton@hartmannsipes.name

Inside of Vim, we could use the expression register to insert the results from this external script into the document:

    :put =system('ruby fake-credentials.rb')

### Ex commands

We can invoke the expression register using the [`:put`][:put] Ex command. For example, this command would insert a new line containing the text '9.0':

    :put =sqrt(81)

When we invoke the expression register from Insert mode (via `<C-r>=`), the result is inserted at the current cursor location. Whereas the `:put` Ex command always inserts the result on a new line.

We could use this same technique to insert fake credentials from our simple ruby script:

    :put =system('ruby fake-credentials.rb')

If you're only using the expression register to get output from an external script, then there's an even quicker way of doing it: using the `:read!` "read-bang" Ex command.

    :read !ruby fake-credentials.rb

This executes the specified command in the shell and outputs the results directly into the document below the cursor position.


### Further reading

* [`:h i_ctrl-r`][i_ctrl-r]
* [`:h quote=`][quote=]
* [`:h function-list`][function-list]
* [`:h float-functions`][float-functions]
* [`:h system()`][system()]
* [`:h sqrt()`][sqrt()]
* [`:h :put`][:put]
* [`:h :read!`][:r!]
* [`:h @:`][@:]
* [Practical Vim][pv], Tip 16: Do back-of-the-envelope calculations in place
* [Practical Vim][pv], Tip 35: Run Commands in the shell
* [Native Vim Random Number script][rand()] on StackOverflow
* [faker][] gem for generating fake user credentials

[i_ctrl-r]: http://vimdoc.sourceforge.net/htmldoc/insert.html#i_CTRL-R
[system()]: http://vimdoc.sourceforge.net/htmldoc/eval.html#system()
[sqrt()]: http://vimdoc.sourceforge.net/htmldoc/eval.html#sqrt()
[quote=]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote=
[@:]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#@:
[function-list]: http://vimdoc.sourceforge.net/htmldoc/usr_41.html#function-list
[float-functions]: http://vimdoc.sourceforge.net/htmldoc/usr_41.html#float-functions
[:put]: http://vimdoc.sourceforge.net/htmldoc/change.html#:put
[:r!]: http://vimdoc.sourceforge.net/htmldoc/insert.html#:r!
[pv]: http://pragprog.com/book/dnvim/practical-vim
[rand()]: http://stackoverflow.com/a/12739441/128850
[faker]: http://rubygems.org/gems/faker
