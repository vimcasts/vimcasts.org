--- 
:title: Using :argdo to change multiple files
:date: 2013/02/25
:poster: /images/posters/argdo.png
:flattr_id: "1150023"
:duration: 340
:ogg: 
  :url: http://media.vimcasts.org/videos/43/argdo.ogv
  :size: 7790359
:quicktime: 
  :url: http://media.vimcasts.org/videos/43/argdo.m4v
  :size: 12538524

---

The `:argdo` command allows us to execute an Ex command across all buffers in the arglist.  To demonstrate, we'll use the example of running the `:substitute` command across multiple files, then we'll see how to revert or save the changes.  We'll also compare the `:argdo` and `:bufdo` commands, and consider when it's appropriate to use each one.

READMORE

<r:snippet name="announcement"/>

The `argdo` command works like this:

    :argdo {cmd}

Where `{cmd}` could be any Ex command, such as `:substitute`, `:global`, or `:normal` for example. This is just like running:

    :first
    :{cmd}
    :next
    :{cmd}
    etc...

The `argdo` command works best when the [`'hidden'`]['hidden'] setting is enabled. For more information, see Vimcast [episode 6 - Working with buffers][6].

### Using `argdo` with `substitute`

The video demonstrates how to use `argdo` with the `substitute` comamnd. We start off simple:

    :argdo %s/\a/*/g

There's a problem with this command: if any of the buffers in the argument list do not contain a match for the pattern specified by the substitute command (in this case `\a`), then the substitue command will raise an error: `E486 pattern not found`. We can suppress this error by modifying the substitute command with the `e` flag (see [`:help :s_flags`][:s_flags]):

    :argdo %s/\a/*/ge

That cuts down some of the noise, but the substitute command still reports details of about the effect it has on each file in the argument list. We can suppress that output by prefixing the whole thing with [`silent`][:silent]:

    :silent argdo %s/\a/*/ge

Alternatively, we could use `:silent!`, which would suppress all output *including error messages*. That way, we could leave out the `e` flag:

    :silent! argdo %s/\a/*/g

### Pasting the last Ex command into the command line

On the command line, you can paste the contents of a register by pressing [`<C-r>{register}`][c_CTRL-R]. In this context, the [`quote:`][quote:] register comes in handy: it contains the last executed Ex command. For example, if we start out by running a simple substitute command:

    :%s/\a/*/g

To prefix this with argdo, simply type `:argdo`, then a space, then `<C-r>:` which will produce:

    :argdo %s/\a/*/g

After executing this command, the `:` register will contain `argdo %s/\a/*/g`. We could prefix this with `silent` by typing `:silent`, space, then `<C-r>:` to produce:

    :silent argdo %s/\a/*/g

You get the idea?

### :argdo Vs :bufdo

Just as we can use `:argdo` to execute a command on each of the files in the arglist, we can use `:bufdo` to execute a command on each of the files in the buffer list. In some circumstances, the buffer list and arglist may refer to the same set of files. In this case, it would make no difference whether you used `:bufdo` or `:argdo`.

It's easy to add files to the buffer list (perhaps unintentionally), so if you use `:bufdo` there's always a risk that it might end up touching a file that you didn't mean to change. Whereas the arglist only changes when you tell it to. For that reason, I prefer to use `:argdo` instead of `:bufdo`.

### Further reading

* [`:help :argdo`][:argdo]
* [`:help 'hidden'`]['hidden']
* [`:help :s_flags`][:s_flags]
* [`:help :silent`][:silent]
* [`:help :edit!`][:edit!]
* [`:help :update`][:update]
* [`:help :bufdo`][:bufdo]
* [`:help c_CTRL-R`][c_CTRL-R]
* [`:help quote:`][quote:]
* [Working with buffers][6]

[6]: /e/6
[:argdo]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:argdo
['hidden']: http://vimdoc.sourceforge.net/htmldoc/options.html#'hidden'
[:s_flags]: http://vimdoc.sourceforge.net/htmldoc/change.html#:s_flags
[:silent]: http://vimdoc.sourceforge.net/htmldoc/various.html#:silent
[:edit!]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:edit!
[:update]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:update
[:bufdo]: http://vimdoc.sourceforge.net/htmldoc/windows.html#:bufdo
[c_CTRL-R]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[quote:]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote:
