--- 
:title: Supercharged substitution with :Subvert
:date: 2013/04/22
:poster: /images/posters/abolish-substitute.png
:flattr_id: "1274469"
:duration: 429
:number: 48
:ogg: 
  :url: http://media.vimcasts.org/videos/48/abolish-substitute.ogv
  :size: 9326785
:quicktime: 
  :url: http://media.vimcasts.org/videos/48/abolish-substitute.m4v
  :size: 17311862

---

The [abolish plugin][abolish] provides a command called `:Subvert`, which is like a supercharged version of Vim's built-in `:substitute` command. The `:Subvert` command is especially useful for changing singular and plural variants of a word, and for refactoring names that appear in `snake_case` and `MixedCase`.

*This is part two of a three-part series on Tim Pope's [abolish][] plugin.*

[abolish]: https://github.com/tpope/vim-abolish


READMORE


In [Episode 47](/e/47), we saw how the `:Subvert` command can be used as a smart search command. In this episode, we learn about this form of the `:Subvert` command:

    :[range]Subvert/target/replacement/[flags]

`:Subvert` behaves a lot like Vim's standard `:substitute` command: it accepts the same flags and operates the same way over a range, but the target and replacement fields are handled differently.

Suppose that we wanted to change the word `pumpkin` to `potato`. We could use the `:Subvert` command:

    :%S/pumpkin/potato/g

This looks a lot like Vim's built-in `:substitute` command. In fact, if we used a lowercase `s` then this would be a valid `:substitute` command. But `:Subvert` does a bit of extra work for us. Not only will it change `pumpkin` to `potato`, it will also change `Pumpkin` to `Potato`, and even `PUMPKIN` to `POTATO`.

### Working with irregular plurals

The plural form of `potato` is irregular: it ends with `-es`. We can adapt the `:Subvert` command from above to handle singular and plural forms like this:

    :%S/pumpkin{,s}/potato{,es}/gc

This will change `pumpkins` to `potatoes` and `pumpkin` to `potato`. That's pretty handy!

We could also use the `:Subvert` command to switch from a word with irregular singular/plural forms to a regular word. Suppose we needed to change `mouse` to `trackpad`. The `:Subvert` command could handle it like this:

    %S/m{ouse,ice}/trackpad{,s}/gc

This command will change `mouse` to `trackpad` and `mice` to `trackpads`. As before, it will work for Titlecase and SHOUTYCASE variants too.

### Working with `snake_case` and `MixedCase`

The `:Subvert` command can also target `snake_case` and `MixedCase` forms of a word. Suppose that we needed to change `insert_mode` to `replace_mode`. We could use this command:

    :%S/insert_mode/replace_mode/gc

Not only will this change `insert_mode` to `replace_mode`, but it will change `InsertMode` to `ReplaceMode`, and `INSERT_MODE` to `REPLACE_MODE` as well. That can be really handy when refactoring code.

### Swapping words

We could use the `:Subvert` command to swap all occurrences of `vim` and `tmux` in this [tweet][]:

    :S/{vim,tmux}/{tmux,vim}/g

That would change each instance of `vim` to `tmux` and vice versa.

### Further reading

* [abolish][] by tpope
* :help :Subvert
* :help abolish-substitute
* [`:help c_CTRL-R`][reg]

[abolish]: https://github.com/tpope/vim-abolish
[reg]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[tweet]: https://twitter.com/tpope/status/316783714019442688
