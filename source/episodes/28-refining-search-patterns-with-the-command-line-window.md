--- 
:title: Refining search patterns with the command-line window
:date: 2010/11/21
:poster: /images/posters/commandline_window.png
:flattr_id: "86560"
:duration: 471
:number: 28
:ogg: 
  :url: http://media.vimcasts.org/videos/28/commandline_window.ogv
  :size: 10505095
:quicktime: 
  :url: http://media.vimcasts.org/videos/28/commandline_window.m4v
  :size: 14088176
:tags: search, regex, workflow
:layout: episode
---

When you need to build a complex command, or devise a non-trivial search pattern, Vim's command-line mode can be rather limiting. In this episode, I will introduce the command-line window, which allows you to use the full power of Vim when editing search queries and commands.

READMORE


Commandline mode
----------------

When you press `:` or `/` in Vim, you go into commandline mode. This opens up a prompt at the bottom of the screen, where you can enter a command or a search pattern.

In commandline mode, you can press `ctrl-p` to go backwards and `ctrl-n` to go forwards through your command history. The up and down arrow cursor keys also work.

<table>
   <tr>
     <th>command</th>
     <th>action</th>
   </tr>
   <tr>
     <td><code>ctrl-p</code></td>
     <td>Show previous historical command/search</td>
   </tr>
   <tr>
     <td><code>ctrl-n</code></td>
     <td>Show next historical command/search</td>
   </tr>
   <tr>
     <td><code>ctrl-f</code></td>
     <td>Switch from commandline mode to the commandline window</td>
   </tr>
</table>

If you need to make extensive edits to a command, change to the commandline window by pressing `ctrl-f`.

Note that `ctrl-f` is the default, but it can be customized using the `cedit` option. Read [`:help cedit`][cedit] for more information.

The commandline window
----------------------

The commandline window shows your last 20 search patterns or commands. You can move up and down through them with the `k` and `j` keys, and when you press `<enter>` it executes the command underneath the cursor.

The cool thing about the command-line window is that it's a regular Vim buffer, so all of the editing commands that you are used to are available to you. This makes it extremely useful if you need to iterate on a search pattern.

<table>
   <tr>
     <th>command</th>
     <th>action</th>
   </tr>
   <tr>
     <td><code>q/</code></td>
     <td>Open the commandline window with history of searches</td>
   </tr>
   <tr>
     <td><code>q:</code></td>
     <td>Open the commandline window with history of commands</td>
   </tr>
   <tr>
     <td><code>ctrl-f</code></td>
     <td>Switch from commandline mode to the commandline window</td>
   </tr>
</table>

Note that you can customize the number of commands that Vim remembers with the [`history`][history] setting.

Replacing prime marks with curly quotes
---------------------------------------

In the video, I use the following example as a demonstration:

    This string contains a 'quoted' word.
    This string contains 'two' quoted 'words'.
    This 'string doesn't make things easy'.

My intention is to replace the prime marks with curly double quotes, so that it looks like this:

    This string contains a â€œquotedâ€ word.
    This string contains â€œtwoâ€ quoted â€œwordsâ€.
    This â€œstring doesn't make things easyâ€.

To create a suitable search pattern, I went through the following iterations:

    \v'.+'
    \v'[^']+'
    \v'('\w|[^'])+'
    \v'(('\w|[^'])+)'

The final pattern works for each of my test cases, so I can use it for a substitution command as follows:

    /\v'(('\w|[^'])+)'
    :%s//â€œ\1â€/gc

Here, I've left the search field blank in the substitution command, which tells Vim to use the most recent search. Alternatively, I could hard code the search pattern into the substitution command:

    :%s/\v'(('\w|[^'])+)'/â€œ\1â€/gc

When making this substitution on an entire document, I use the `c` flag so that I can inspect each substitution before either doing it or skipping it.

### Homework

Note that this substitution command is not a complete solution for replacing prime marks with curly double quotes. It works for my 3 test cases, but there are other situations where it will fail. Here is one:

    This string doesn't contain any quotes, isn't it.

Your homework, should you choose to accept it, is to refine the search pattern so that it handles this case appropriately. See if you can think up other failing test cases, and hone the substitution command to work for those as well. 

### Further reading

* [:help q:][cwin] - the command line window
* [:help cedit][cedit] - the key used in Command-line mode to open the command-line window
* [:help :s[ubstitute]][s] - the substitute command
* [:help :s_flags][s_flags] - the flags for the substitute command
* [:help /magic][v] - searching with *very magic* mode

[cwin]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#q:
[cedit]: http://vimdoc.sourceforge.net/htmldoc/options.html#'cedit'
[s]: http://vimdoc.sourceforge.net/htmldoc/change.html#:s
[s_flags]: http://vimdoc.sourceforge.net/htmldoc/change.html#:s_flags
[v]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/magic
[history]: http://vimdoc.sourceforge.net/htmldoc/options.html#'hi'
