## Using vimgrep on the current file

Here's a common search use-case in Vim. We start by searching for a pattern: here I'm using a regular expression that matches text wrapped in backticks. Then we can use the `n` command to jump through the matches.

    /\v`[^`]*`
    nnn

When we get to the bottom of the file, Vim cycles round to the top, and keeps going. If you watch closely, you'll see a message that says:

    Search hit bottom, continuing at top

but it's easy to miss that message. For that reason, I occasionally become disoriented, and don't realize that I'm revisiting matches that I've already looked at. Have you ever wished that Vim would report your position, by saying, for example: 'this is match 2 out of 5'?

That's not a feature provided by Vim's search command, but it is a feature supplied by the quickfix list. We can use the `:vimgrep` command to populate the quickfix list with search results from the current file.

    :vimgrep /pattern/g %

Let's use `vimgrep` to search for the same pattern as before.

We'll break down how this command works in just a minute, but first lets look at the result. The cursor has jumped to the first match in the file, and there's a message at the bottom of the screen saying `(1 of 9)`. We can advance through the records in the quickfix list using the `:cnext` command. Note that the quickfix status message updates each time (1 of 9, 2 of 9, and so on). We can reverse through the matches with the `:cprev` command.

I prefer to use the quickfix mappings provided by Tim Pope's unimpaired plugin.

    [q - :cprev
    ]q - :cnext
    [Q - :cfirst
    ]Q - :clast

Using these, I can quickly navigate the matches in this file.  Note that when I reach the end of the list, it doesn't cycle round to the beginning when I try to advance.

## Mechanics of the :vimgrep command

Let's have a closer look at the `:vimgrep` command.

    :help vimgrep
    :vim[grep] /pattern/ {file} ...

This command takes two arguments: a pattern, and a set of files to search.

When we ran the `vimgrep` command a minute ago, we supplied the `%` symbol, which is a special symbol that represents the filepath of the active buffer. Note the elipsis in the documentation. This indicates that we can supply the path to more than one file and the `vimgrep` command will search the contents of each one.

Let's try that out. This directory contains 3 markdown files. We'll use `vimgrep` to search through all of them. For starters, we'll hardcode the explicit filepath for each file:

    :vim /\v`[^`]*`/g abstract.md script.md shownotes.md

That seems to have worked. Our quickfix list now contains 24 results. If we advance through the list, you'll see that it traverses the three specified files.

But we don't have to spell out the filepaths one by one. Instead, we could use a wildcard:

    :vim /pattern/ *.md

Which produces the same result.

Or, we could even use a backtick expression!

    :vim /pattern/ `find . -type f`

Which also has the same effect.

To recap, we can provide

* one or more filepaths
* a wildcard
* or a backtick expression

Does that sound familiar? If you've watched episode 42, then you'll recognise these as being the same arguments that we can use to populate the arglist.

But get this: there's one additional argument that can be passed to the `vimgrep` command: `##` (double-hash).

    :help ##

This is a special symbol that represents the set of files in the arglist. It's really handy in this context. Suppose that we wanted to search the same set of files for one pattern, then another pattern, and so on. It would be a drag to have to specify the same set of files again and again:

    :vim /pattern1/ *.md
    :vim /pattern2/ *.md
    :vim /pattern3/ *.md

We can avoid this repetition by populating the arglist with the set of files we want to work with, then using the special symbol `##` (double hash) to reference the arglist:

    :args *.md
    :vim /pattern1/ ##
    :vim /pattern2/ ##
    :vim /pattern3/ ##

Not having to think about which files you're dealing with frees you up to focus on the more interesting part of the `vimgrep` command: the pattern.

## Specifying the pattern

The pattern field behaves more or less as you would expect. You can supply any pattern that would work with Vim's standard search command. However, there is one irregularity to watch out for.

If we run the `vimgrep` command with a blank pattern, it doesn't do what you might expect.

    :vim //g %

This has created a match for every single character in the file, which is unfortunate. It would be nice if this worked the same way as the `substitute` and `global` commands. If you leave the pattern blank for either of these commands, then they automatically use the most recent search pattern.

If you want to use the last search pattern with `vimgrep`, there is a way: on the command line, control-r followed by forward slash will insert the last search pattern. So we can type "vim slash, control-R slash", then close the search field and finish off the command:

    :vim /<C-r>//g %

You may have noticed that throughout this demo, I've always included the `g` flag after the search field. Without this flag, `vimgrep` would only match the first occurrence on each line where the pattern appears.

## Pros and cons

If you want to search a large codebase and get results fast, then you'd be better off using an tool like `git-grep`, `ack` or the silver searcher. All of these external tools integrate with the quickfix list, and you can find Vim plugins for each of them.

Vimgrep won't produce results as quickly as these external tools, but it's still useful. I reach for `vimgrep` when I want to use Vim's built-in regex engine. I love being able to test my regular expression in one buffer using the search command, then use the same pattern without modification to search across the entire project. For me, that convenience is the killer feature of `vimgrep`.