# Introduction to vspec

## Installation

vspec is written by Kana Natsuno. You can find the library on GitHub, and Kana's blog has instructions on how to set up a Vim plugin to use vspec. I won't demonstrate those steps in this video, but you can find links in the shownotes for this episode.

I've set things up here so that I can run the vspec tests using the rake command. I've also defined a mapping that lets me execute the tests from inside of Vim. There's nothing to see yet, so let's write some tests.

## First test

Vspec lets you write tests following a format that resembles rspec. We can use a `describe` block to specify a context, then wrap each individual test in an `it` block. Each of these blocks is closed with an `end` keyword, just like in ruby:

    describe 'vspec'
      it 'is inspired by rspec'
      end
    end

We can place Vimscript code inside of these blocks and it will be executed by the vspec runner.

Let's start by making an assertion using the `Expect` command, which is provided by vspec:

    Expect getline(1) == "Welcome to Vimcasts"

You can read that as: `expect line one to equal "Welcome to Vimcasts"`. Let's execute the vspec runner, and we should have our first failing test...

vspec shows the expected result and the actual value, which in this case is a blank string.

Now let's make that test pass. The simplest thing I can do here is to use the `:put` Ex command, which adds a line of text to the current buffer.

    :put! = 'Welcome to Vimcasts'

Run vspec...

And we have our first passing test!

## What does the vspec runner do?

What happens when we execute the vspec runner?

First, vspec runs a preprocessor to translate the `describe` and `it` blocks into pure executable Vimscript. Then the vspec runner launches Vim in Ex mode and executes each line of Vimscript. Using Ex mode means that Vim runs without taking over your terminal screen to draw its user-interface. Think of it as a headless instance of Vim, if you like.

Let's launch a separate Vim session to simulate what happens when vspec runs. Vim launches with an empty buffer, and running the `put` command adds one line of text:

    :put! = 'Welcome to Vimcasts'

We don't have access to the vspec `Expect` command in this context, so let's just echo the result of the `getline()` command:

    :echo getline(1)

## Change the buffer and test the result

We can run any Ex command in our vspec tests. But what if we want to simulate running normal commands? For example, if I wanted to delete the last word on this line, I would normally do so by pressing `$`, then running `daw`.

[undo the changes]

We can exercise these normal mode commands using an Ex command called `:normal`. Watch this:

    :normal $

moves to the end of the line, and 

    :normal daw

deletes the word. It's just as though I had typed those commands in Normal mode.

[switch back to the tests]

Let's set up a second test:

    it 'feels just like operating Vim!'
    end

We'll use the `:normal` command to move to the end of the first line, then delete a word.

I'm going to duplicate the assertion from our first test, expecting this test to fail...

    Expected: "Welcome to Vimcasts"
    Actual: "Welcome to"

It looks as though our normal commands have indeed changed the contents of the buffer.

We can make the test pass by changing the expected string:

    Expect getline(1) == "Welcome to"

And now we're back on green again.

There's something else that we could test for in this case. The delete command doesn't only change the contents of the buffer, it also saves the deleted text to a register. We can check this using the `getreg()` command:

    Expect getreg('"') == 'Vimcasts'

The double-quote symbol stands for the default register. Run that test...

We have a failure, which is easily mended by prefixing a space at the start of the expected string.

And now the test passes.

## Meet before and after blocks

So far, our tests show that we can read and modify the contents of a buffer. But there's a problem with this test suite as it's written. The quickest way I can demonstrate is by switching the order of the two tests.

Now we have a failure. Can you see why?

We start by populating the buffer with a string of text. Then our first test modifies the buffer, which breaks the second test.

We can fix this by using a `before` block.

    before
    end

Let's move our setup code from the top of the file to inside the before block. Now this line of code is executed before every test run within this describe block.

[run tests]

And now our tests pass again. It doesn't matter which order they appear in.

[swap order again]
[run tests]

...they still pass.

## Using tabs for clean setup/teardown 

We can further isolate our tests by using the `:new` command to create a fresh buffer before each test. Then we can use the `:close!` command in an after block to tear down the fresh buffer:

    before
      new
      put! = 'Welcome to Vimcasts'
    end
    after
      close!
    end

As you would expect, the code in the after block is executed at the end of each test.

## We can use custom keymappings

Vspec can load customizations such as mappings, functions, and commands, then we can invoke them in our tests.

Suppose that we wanted to map the `x` key to behave the same way as though we'd typed `daw`.

Let's duplicate and modify our last test:

* instead of running `daw` we'll just use `x`
* and we'll change the description of the spec

    it 'can exercise user-defined mappings'
      normal gg$
      normal x
      Expect getline(1) == 'Welcome to'
      Expect getreg('"') == ' Vimcasts'
    end

That fails. We haven't defined our `x` mapping yet, so Vim invokes the built-in `x` command, which deletes a single character.

Let's define our mapping for normal mode:

    nnoremap x daw

Now the test passes!

## On testing plugins

Defining a mapping inside a test file means it's no use to anyone. It would be more practical to define custom functionality in one file, and the tests in another. That's easy. Let's create a file called `demo.vim`, and move this mapping into it. Then, in the test file, I'll source the `demo.vim` file. Run the tests... and they're still green.

This pattern makes it possible to write vspec tests for the functionality specified by a Vim plugin.
