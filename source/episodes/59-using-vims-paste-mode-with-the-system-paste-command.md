--- 
:title: Using Vim's paste mode with the system paste command
:date: 2013/11/15
:tags: registers
:poster: /images/posters/paste-option-toggle.png
:flattr_id: ""
:duration: 265
:number: 59
:ogg: 
  :url: http://media.vimcasts.org/videos/59/paste-option-toggle.ogv
  :size: 5456772
:quicktime: 
  :url: http://media.vimcasts.org/videos/59/paste-option-toggle.m4v
  :size: 9844252

---

When Vim is compiled without the `+clipboard` feature, we can still insert text from the clipboard using the system paste command (`ctrl-v` or `cmd-v`). This can produce strange effects, but we can avoid them by toggling the `paste` option each time we use the system paste command.

READMORE


If you [copy this snippet of JavaScript][gist], then use the system paste command (`ctrl-v`, or `cmd-v` for mac users) to paste it into a Vim session running in the terminal, you might end up with something that looks like this:

    for (var i = 1; i <= 100; i++) {
          if (i % 15 == 0) {
                  console.log("FizzBuzz");
                    } else if (i % 3 == 0) {
                            console.log("Fizz");
                              } else if (i % 5 == 0) {
                                      console.log("Buzz");
                                        } else {
                                                console.log(i);
                                                  }
    }

The problem is that when Vim runs inside a terminal, it can't distinguish between characters that are typed manually and those that are pasted. In this case, each time Vim creates a new line, it's autoindented. Add on top of that the indentation that was already present the source code, and we end up with each line drifting farther and farther to the right.

We can avoid this by enabling the `paste` option, which temporarily disables several settings that can interfere when pasting text.

    :set paste

With that option enabled, the system paste command should work in Insert mode just fine.

### Why not keep 'paste' enabled at all times?

You might be thinking: Why not keep the `paste` option enabled at all times? Here's the gotcha: when the paste option is enabled, any abbreviations or mappings defined for Insert mode will be disabled. For example, suppose that you have this mapping set up, to swich from Insert to Normal mode by typing `kj`:

    :inoremap kj <Esc>

If the `paste` option is enabled, then typing `kj` will insert those characters into the document. But with the `paste` option disabled, typing `kj` will behave just as though you pressed `<Esc>`.

So remember: with the `paste` option enabled, you're safe to use the system paste command, but any user-defined Insert mode mappings will fail. For that reason, it's a good idea to turn off the `paste` option as soon as you're finished using it.

If you're thinking of creating a mapping to make it easier to toggle the paste option, don't forget that your mapping won't work in Insert mode! Read Vim's documentation on [`'pastetoggle'`][pastetoggle] to learn about a workaround.

### The unimpaired workflow

I like the approach that's enabled by Tim Pope's [unimpaired plugin][vim-unimpaired]. In [the documentation][yopo], he notes that:

> you toggle twice, but you only paste once ([YOPO][yopo]).

Unimpaired provides a `yo` mapping. Just like the regular `o` command, it opens a new line and switches to Insert mode, but the `yo` variant also enables the `paste` option making it safe to use the system paste command. It uses an autocommand to disable the `paste` option when you return to Normal mode. That's a much neater workflow than having to toggle the `paste` option on and off again manually.

### Further reading

* [:h 'paste'][paste]
* [:h 'pastetoggle'][pastetoggle]
* [vim-unimpaired][] provides a smoother workflow - ["you only paste once"][yopo]

[paste]: http://vimdoc.sourceforge.net/htmldoc/options.html#'paste'
[pastetoggle]: http://vimdoc.sourceforge.net/htmldoc/options.html#'pastetoggle'
[vim-unimpaired]: https://github.com/tpope/vim-unimpaired
[yopo]: https://github.com/tpope/vim-unimpaired/blob/a029dc28ebc1ba5953cd5b0ef9a50bd0ffba3aa4/doc/unimpaired.txt#L88-L94
[gist]: https://gist.github.com/nelstrom/7416573
