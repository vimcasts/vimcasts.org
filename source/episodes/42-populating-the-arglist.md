--- 
:title: Populating the arglist
:date: 2013/02/22
:poster: /images/posters/arglist_populate.png
:flattr_id: "1146839"
:duration: 331
:number: 42
:ogg: 
  :url: http://media.vimcasts.org/videos/42/arglist_populate.ogv
  :size: 6533057
:quicktime: 
  :url: http://media.vimcasts.org/videos/42/arglist_populate.m4v
  :size: 11150926

---

The arglist wouldn't be much use if we had to quit and relaunch Vim every time we wanted to change its contents. In this episode, we'll learn how to set the contents of the arglist using the `:args` command, which can receive filepaths, globs, or even backtick expressions.

READMORE


When run with no arguments, the `:args` command reveals the contents of the arglist. But when a valid `{arglist}` is passed to the `:args` command it sets the contents of the arglist:

<table>
   <tr>
       <th>Ex command</th>
       <th>effect</th>
   </tr>
   <tr>
       <td><code>:args</code></td>
       <td>show the contents of the arglist</td>
   </tr>
   <tr>
       <td><code>:args {arglist}</code></td>
       <td>set the contents of the arglist</td>
   </tr>
</table>

The `{arglist}` could be:

1. one or more filepaths (separated by whitespace)
2. a wildcard
3. a backtick expression
4. a combination of the above

As a general rule: anything that you can provide as an argument to the Vim executable at the commandline can also be supplied as an argument to the [`:args`][args] command.

Backtick expression are particularly powerful. In the video, I use the simple example of running <code>:args \`cat .toc\`</code> to use the contents of a plaintext file to populate the arglist, but we could put anything inside that backtick expression. So long as the subshell returns a list of filepaths, then Vim will consider it as valid input.  For example, you could use the output of `find` or `grep`, or even a shell script of your own. 

## Further reading

* [`:help :args_f`][args]
* [`:help {arglist}`][arglist]
* [`:help wildcards`][wildcards]
* [`:help starstar-wildcard`][starstar]
* [`:help backtick-expansion`][backtick]
* [command substitution in bash](http://wiki.bash-hackers.org/syntax/expansion/cmdsubst)
* [`:help 42`](http://vimdoc.sourceforge.net/htmldoc/usr_42.html#42)

[args]: http://vimdoc.sourceforge.net/htmldoc/editing.html#:args_f
[arglist]: http://vimdoc.sourceforge.net/htmldoc/editing.html#{arglist}
[wildcards]: http://vimdoc.sourceforge.net/htmldoc/editing.html#wildcards
[starstar]: http://vimdoc.sourceforge.net/htmldoc/editing.html#starstar-wildcard
[backtick]: http://vimdoc.sourceforge.net/htmldoc/editing.html#backtick-expansion
