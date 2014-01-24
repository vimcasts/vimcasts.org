# Populating the arglist

When launching Vim from the command line, we can supply arguments in a few different ways. The simplest way is to specify one or more filepaths.

In this directory, we've got 5 text files named A, B, C, D, and E:

    $ ls -l
    total 40
    -rw-r--r--  1 drew  staff    0 17 Feb 15:40 README
    -rw-r--r--  1 drew  staff  544 14 Jan 14:38 a.txt
    -rw-r--r--  1 drew  staff  336 14 Jan 14:38 b.txt
    -rw-r--r--  1 drew  staff  352 14 Jan 14:38 c.txt
    -rw-r--r--  1 drew  staff  352 14 Jan 14:38 d.txt
    -rw-r--r--  1 drew  staff  368 14 Jan 14:38 e.txt

We could launch Vim specifiying one or more filepaths directly:

    vim a.txt b.txt

As you might expect, that populates the arglist with the two specified files:

    :args
    [a.txt] b.txt
    :q

Alternatively, we could supply a wildcard when launching Vim:

    vim *.txt

The bash shell expands the wildcard to match all five text files in the current directory, and those five files appear in the arglist when Vim launches.

## Changing the arglist at runtime

The arglist wouldn't be that much use if it could only be changed by quiting and then relaunching Vim. It turns out that you can change the contents of the arglist at runtime, using the `:args` command:

    :help :args

Remember, it's called the arglist because it starts out containing the list of arguments that were passed to Vim when it was launched from the command line. But the fact that you can change the contents of the list while Vim is running means that the name 'argument list' is a bit of a misnomer. Don't underestimate this feature!

Just as you can pass filepaths and wildcards to Vim on the commandline, you can do the same with the :args command. At the moment, we've got 5 items in the arglist:

    :args
    [a.txt] b.txt c.txt d.txt e.txt

We could contract the arglist to reference just two of these buffers by specifying them with the args command:

    :args a.txt b.txt

Now the arglist contains only two buffers:

    :args
    [a.txt] b.txt

Whereas the buffer list still contains all of the files that were specified at launch:

    :ls
    ...

Remember in episode 41, I said that it's useful to think of the arglist as being a subset of the buffer list? Being able to set the contents of the arglist at runtime allows us to define a small working subset of buffers. 

We could easily restore the arglist to its previous state with a single command:

    :args *.txt
    :args
    [a.txt] b.txt c.txt d.txt e.txt

As a general rule: anything that you can provide as an argument to the Vim executable at the commandline can also be supplied as an argument to the `:args` command.

Now let's have a look at a more complex example.

## Using backticks

This directory contains about 30 markdown files, which correspond to the chapters of my book, Practical Vim. Suppose that we want to open each of these chapters in Vim, we could do so using a wildcard:

    vim *.md

That's quick and dirty and it gets the job done, but it lists the chapters in alphabetical order. I'd like to have the files listed in the order that they appear in the book, so I've created a hidden file called `.toc`. Let's inspect it's contents with the `cat` command:

    $ cat .toc

This file simply mirrors Practical Vim's table of contents.

Now watch this, if we wrap the cat command in backticks, then it will run in a subshell. We can use the output from the subshell as the arguments to launch Vim:

    $ vim `cat .toc`

Now the arglist contains all of the chapters in the order that they appear in the table of contents:

    :args
    [introduction.md] the_vim_way.md ...

Pretty neat!

Earlier on, I stated a general rule that any arguments that can be passed to the Vim executable at the command line can also be supplied to the `:args` command.  So what about backtick expressions like this one?

Well let's launch Vim again, opening the `toc` file:

    :q
    $ vim .toc

That populates the arglist with a single buffer:

    :args
    [.toc]

We can quickly set the arglist to contain each of the files listed in the table of contents by running "args with the cat command in backticks":

    :args `cat .toc`

Boom! The backtick expression works just as it does in the shell:

    :args
    [introduction.md] the_vim_way.md ...

## More ideas for using backtick expressions

I've chosen a simple example for demonstration purposes, but we could put anything inside that backtick expression.  So long as the subshell returns a list of filepaths, then Vim will consider it as valid input.  For example, you could use the output of `find` or `grep`, or even a shell script of your own.  I'm sure that you can think of lots of other possibilities.
