# Executing commands on the arguments list

The arglist really shines when you want to perform the same commands across a set of files, thanks to the `:argdo` command:

    :help :argdo

Vim's documentation has a nice illustration of how this works. Whatever command we specify with the `:argdo` command will be executed in each of the buffers in the arglist. By the way, the `:rewind` command does the same thing as `:first`.

Suppose, for example, that we want to run a substitute command across each of the buffers in the arglist. We'll start off by running the substitute command on the current file, just to check that it works as expected:

    :%s/\a/*/g

Here, we're matching every letter character and replacing it with a star. 

[run the command]

That has the effect I was looking for, so let's run the same command, but prefix it with `:argdo`.

By the way, after typing `:argdo`, we can paste the last Ex command in place by pressing 'control-r followed by colon'.

    :argdo %s/\a/*/g
    E37: No write since last change (add ! to override)

That command raises an error: by default, Vim won't navigate away from a buffer with unsaved changes. The easiest way to suppress this behavior is to enable the `'hidden'` setting:

    :set hidden

Refer back to Vimcast episode 6 for more details about this option.

Having enabled the hidden setting, let's have another go at running that substitute command across the files in the arglist:

    :argdo %s/\a/*/g

Note that Vim shows a bit of information about the effect that the command had on each buffer. Also, note that an error message was raised in the first buffer. The substitute command found no matches for the specified pattern, and that's because we had already ran the substitute command in the first buffer.

If we were to run the exact same command again, every buffer would produce the same error message:
        
    :argdo %s/\a/*/g
    E486: Pattern not found \a
    E486: Pattern not found \a
    E486: Pattern not found \a
    E486: Pattern not found \a
    E486: Pattern not found \a

We can suppress this error message by using the substitute command with the `e` flag. 

    :help :s_flags

It's generally a good idea to include the `e` flag when running the substitute command across multiple files.

    :argdo %s/\a/*/ge

Note that Vim still prints a short info message for each buffer in which the command runs. It doesn't really say anything useful, so we could suppress it by prefixing `argdo` command with `:silent`:

    :silent argdo %s/\a/*/ge

## Discarding changes or saving them

Suppose that we realize we've made some mistake after running a command across all the buffers in the arglist, and we'd like to revert the changes. We could visit each file in turn and use the undo command, but that could take ages. Here's a quicker way:

    :silent argdo edit!

The `:edit!` command reverts the buffer to the last saved version.

Now let's run the substitute command again across all of the files in the arglist, changing it this time to replace letters with a dollar sign.

    :silent argdo %s/\a/$/ge

Let's say we're happy with those changes, and we want to keep them. We can use `argdo` again to quickly write each of the files with the `update` command:

    :argdo update

This only writes a buffer to disk if it has been changed.

## :bufdo versus :argdo

Just as we can use `:argdo` to run a command across the set of files in the arglist, we could use the `:bufdo` command to run a command across the set of files in the buffer list.

    :help bufdo

So you might be wondering why we're using `argdo` here instead of `bufdo`?  At the moment, the arglist and buffer list reference the same 5 buffers:

    :args
    :ls
    1 %a   "a.txt"                        line 16
    2      "b.txt"                        line 0
    3      "c.txt"                        line 0
    4      "d.txt"                        line 0
    5      "e.txt"                        line 0

So it would make no difference whether we used the `:argdo` or `:bufdo` command.  But suppose that we were to open another buffer, the README file:

    :e README

That file now appears in the buffer list:

    :ls
    1 %a   "a.txt"                        line 16
    2      "b.txt"                        line 0
    3      "c.txt"                        line 0
    4      "d.txt"                        line 0
    5      "e.txt"                        line 0
    6 %a   "README"                       line 1

but it does not appear in the arglist:

    :args
    [a.txt] b.txt c.txt d.txt e.txt

If we were to run a substitute command with `bufdo`, then it would modify the README file.

    :bufdo %s/\a/*/ge

That's not what we want, so in this case we'd be better off using the `argdo` command.

It's easy to add files to the buffer list (perhaps unintentionally), so if you use `:bufdo` there's always a risk that it might end up touching a file that you didn't mean to change. Whereas the arglist only changes when you tell it to. For that reason, I prefer to use `:argdo` instead of `:bufdo`.
