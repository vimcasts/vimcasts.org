# Meet the arglist

If we launch Vim without providing any arguments, it will open with an empty buffer (after briefly showing a splash screen).

    vim

If we provide a single filepath as an argument, then Vim will open a buffer containing the contents of that file.

    vim a.txt

But did you know that we can supply multiple filepaths when launching Vim?

    vim a.txt b.txt

Vim keeps a record of the filepaths specified on launch in the argument list (or 'arglist'). We can view the contents of this list by running the Ex command (args):

    :args

The square brackets indicate which of the buffers is active.

If we try to quit Vim, it shows a warning:

    :q
    E173 1 more file to edit

This is meant as a friendly reminder: we opened more than one file when we launched Vim, so Vim assumes that we want to edit (or at least look at) the contents of each of those files. We can prevent that warning by running the q-all command:

    :qall

to close all files and exit.

In this directory, we've got 5 text files named A, B, C, D, and E:

    $ ls -l
    total 40
    -rw-r--r--  1 drew  staff    0 17 Feb 15:40 README
    -rw-r--r--  1 drew  staff  544 14 Jan 14:38 a.txt
    -rw-r--r--  1 drew  staff  336 14 Jan 14:38 b.txt
    -rw-r--r--  1 drew  staff  352 14 Jan 14:38 c.txt
    -rw-r--r--  1 drew  staff  352 14 Jan 14:38 d.txt
    -rw-r--r--  1 drew  staff  368 14 Jan 14:38 e.txt

We could open all five files in Vim with a single command:

    vim *.txt

It looks as though we've only supplied a single argument to Vim, but the shell expands the wildcard to match all 5 text files in the current directory.

    [slide?]

As a result, all 5 files appear in the arglist.

    :args
    [a.txt] b.txt c.txt d.txt e.txt

## Traversing the arglist

Vim provides four basic Ex commands for traversing the arglist. We can advance through the list with the `next` command:

    :next

Or we can use `previous` to reverse through the list:

    :prev

The `last` command takes us to the end of the list, and the `first` command jumps back to the beginning of the list.

Note that the list doesn't loop around, so if we run `previous` while on the first file, it raises an error.

You can shorten `next` to just `n`, but even then it feels like a lot of work to scroll through the arglist: pressing colon-n-enter again and again.
Here's a useful tip: the `@:` "at-colon" mapping repeats the last Ex command. So we can quickly scroll through the arglist with ("next followed by at-colon"):

    :next
    @:
    @:
    @:

I recommend using Tim Pope's unimpaired plugin, which adds a couple of pairs of mappings for interacting with the arglist:

    [a - :prev
    ]a - :next
    [A - :first
    ]A - :last

If you study the list of mappings provided by unimpaired, you'll notice a similar pattern for interacting with the buffer list, the quickfix list, and so on.

In Vimcasts episode 6, we learned about the buffer list, whose contents we can examine by running the `ls` command:

    :ls
    ...

At the moment, the arglist and the buffer list contain the same 5 files. So why do we need them both, you might be wondering?

Well, let me show you one way in which the contents of the arglist and buffer lists can diverge.

    :edit README

If I create a new buffer called `README`, it will add a new entry to the buffer list:

    :ls
    ...

But the arglist is unchanged:

    :args
    [a.txt] b.txt c.txt d.txt e.txt

You can think of the arglist as being a stable subset of the buffer list. The contents of the buffer list can change often, and sometimes without you realizing it. Whereas the arglist will only change its contents when you give an explicit instruction for it to do so.

In the next episode, we'll learn a few ways of populating the arglist at runtime.
