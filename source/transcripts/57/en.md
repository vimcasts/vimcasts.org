# Evaluating scripts with Vim's expression register

### Evaluating simple code

We've already seen how to evaluate simple calculations such as `2*21`. We can actually execute any Vimscript code at the expression register. For example, I could use the `sqrt()` function to calculate the square root of a number:

    =sqrt(81)

The Vimscript standard library contains several functions for working with floating point numbers:

    :h float-functions

We can execute any Vimscript code at the expression register. So long as the expression returns a string (or something that can be converted to a string), then we can use the result. For a complete reference of the functions defined in Vim's standard library, look up `:h function-list`.

### Use :put to evaluate expression and put result on a new line

So far, every time I've demonstrated the expression register, I've done so by pressing "control-R-equals" in Insert mode. But we can also invoke the expression register using the `:put` Ex command:

    :put =sqrt(81)

When we invoke the expression register from Insert mode, the result is inserted at the current cursor location. Whereas the `:put` Ex command always inserts the result on a new line.

### Calling user-defined functions

One thing you won't find in Vim's standard library is a function for generating random numbers. But we could roll our own `Random()` function. This is a bit of a dirty hack, that uses the `reltime()` function to generate a random number from the system clock:

    function! Random()
      return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
    endfunction

Let's source this file:

    :source %

Now we can use the `Random()` function at the expression register:

    :put =Random()<CR>

If you need something that isn't in Vim's standard library, you can always hand roll a Vimscript function of your own.

### Calling external scripts

But there's another alternative that you might prefer. Vim's `system()` function allows us to call some external script, returning it's output:

    :h system()

Instead of hacking together a `Random()` function in Vimscript, we could simply use the `$RANDOM` function that's built-in to the Bash shell.

    :put =system('echo $RANDOM')

Or if we wanted some more complex behaviour, we could write a script using a language of our choice.

For example, suppose that I want to generate a CSV file containing fake names and emails. Here's a tiny script written in Ruby, which uses the `Faker` library to generate fake credentials. Each time I run the script in the shell, it produces a different name and email address.

Inside of Vim, we could use the expression register to insert the results from this external script into the document:

    :put =system('ruby fake-credentials.rb')

### Meet the :read! command

If you're only using the expression register to get output from an external script, then there's an even quicker way of doing it: using the `:read!` "read-bang" Ex command.

    :read !ruby fake-credentials.rb

This executes the specified command in the shell and outputs the results directly into the document below the cursor position.
