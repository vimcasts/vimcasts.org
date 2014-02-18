--- 
:title: Long-range line duplication
:date: 2013/01/09
:poster: /images/posters/line_duplication.png
:flattr_id: "1095405"
:duration: 391
:number: 40
:ogg: 
  :url: http://media.vimcasts.org/videos/40/line_duplication.ogv
  :size: 7569155
:quicktime: 
  :url: http://media.vimcasts.org/videos/40/line_duplication.m4v
  :size: 9929423
:tags: ex-commands, jumps
:layout: episode
---

When writing code, we can often save time by duplicating a line then changing one or two parts of that line to make it suit our purposes. In this episode, we'll compare a few techniques for duplicating lines, and we'll see that the `:copy` Ex command is well suited to this task.


READMORE


### The brief

In the video, we tackle a simple problem. With our cursor on line 16 of this file:

    #sponsors_feature, #sponsors_index {
      width: 120px;
    }
    #sponsors_index {
      position: absolute;
      top: -2px; right: 0;
    }
    #sponsors_index h2 {
      background: #fff url('/images/components.png') -362px -579px;
    }
    #sponsors_feature {
      position: absolute;
      top: 136px; left: 20px;
    }
    #sponsors_feature h2 {
      text-indent: -99999px;
      margin-bottom: 0px;
    }

Copy line 9 and place a duplicate below line 16, to produce this:

    #sponsors_feature, #sponsors_index {
      width: 120px;
    }
    #sponsors_index {
      position: absolute;
      top: -2px; right: 0;
    }
    #sponsors_index h2 {
      background: #fff url('/images/components.png') -362px -579px;
    }
    #sponsors_feature {
      position: absolute;
      top: 136px; left: 20px;
    }
    #sponsors_feature h2 {
      text-indent: -99999px;
      background: #fff url('/images/components.png') -362px -579px;
      margin-bottom: 0px;
    }

### Normal mode solutions

We start with a naÃ¯ve solution:

    kkkkkkk
    yy
    jjjjjjj
    p

Our first refinement speeds up navigation using the *goto line* command ([`:help G`][G]), and the [jumplist][jo]:

    9G
    yy
    <C-o>
    p

### Ex command solutions

An alternative way to *goto line 9* would be `:9`. We can also use the number as a range for the `:yank` command. The cool thing about this technique is that it doesn't move our cursor, so we can cut the number of steps in half:

    :9yank
    p

But we can still do better. Vim has another Ex command that combines the yank and put operations into one: the `:copy` command. This is the longhand form:

    :9copy16

We can compress this down to just three characters:

    :9t.

The `:t` command is simply an alias for `:copy`. When used in an [`{address}`][address] the dot symbol stands for the current line.

### The `:copy` command

Here are some more examples of how the `:copy` command can be used:

<table>
  <tr>
    <th>command</th>
    <th>action</th>
  </tr>
  <tr>
    <td><code>:9t.</code></td>
    <td>copy line 9 placing a duplicate below the current line</td>
  </tr>
  <tr>
    <td><code>:t5</code></td>
    <td>copy the current line placing a duplicate below the line 5 (and moving the cursor)</td>
  </tr>
  <tr>
    <td><code>:-7t.</code></td>
    <td>copy the line 7 before the current cursor position placing a duplicate below the current line</td>
  </tr>
  <tr>
    <td><code>:+4t.</code></td>
    <td>copy the line 4 after the current cursor position placing a duplicate below the current line</td>
  </tr>
  <tr>
    <td><code>:9,11t.</code></td>
    <td>copy the lines 9 to 11 placing the duplicate lines below the current cursor position</td>
  </tr>
</table>

### Further reading

* [`:help CTRL-O`][jo]
* Episode #11: [Using the changelist and the jumplist][11]
* [`:help ''`][bt]
* [`:help :t`][t]
* [`:help :yank`][yank]
* [`:help 'relativenumber'][rnu]
* [`:help {address}][address]
* for more on [Ex command ranges][10.3], see [`:help 10.3`][10.3]

[jo]: http://vimdoc.sourceforge.net/htmldoc/motion.html#CTRL-O
[t]: http://vimdoc.sourceforge.net/htmldoc/change.html#:t
[yank]: http://vimdoc.sourceforge.net/htmldoc/change.html#:yank
[rnu]: http://vimdoc.sourceforge.net/htmldoc/options.html#'relativenumber'
[address]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#{address}
[10.3]: http://vimdoc.sourceforge.net/htmldoc/usr_10.html#10.3
[bt]: http://vimdoc.sourceforge.net/htmldoc/motion.html#%60%60
[G]: http://vimdoc.sourceforge.net/htmldoc/motion.html#G
[11]: /e/11
