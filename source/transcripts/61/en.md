## Introduction

This text sample contains many mistakes:

    iVm's repeta command si supre sueful!

We can correct each of these by pressing `xp`, to transpose two adjacent characters. As I perform the same two changes again and again, I find myself wishing that I could use the dot command, which repeats the last change:

    :help .

In this context, we're performing two small operations on the document:

    x - cuts the current character, saving it to the default register
    p - puts the contents of the default register after the cursor position

The dot command repeats the last change, which is `p` in this case. It would be handy if we could change this behaviour so that Vim treated these two commands as one. The repeat.vim plugin by Tim Pope makes this possible.

## Mapping #1: `cp` to transpose characters

I'd like to be able to press `cp` to transpose two characters in a repeatable fashion. Let's start with something simple:

    nmap cp xp
 
I'll save and source this file, and now pressing `cp` does exactly the same thing as pressing `xp`. Just as before, the dot command repeats the `p` command, not `xp`.


We'll iterate on this, working up to a mapping that uses functionality from repeat.vim to make it play nicely with the dot command.

## Mapping #2: introduce a named mapping

First up, we'll use the special `<Plug>` key to create a named mapping. A custom mapping usually instructs Vim to execute the keys on the RHS of the expression, whenever the user presses the keys on the LHS. Named mappings are different: they can't be executed directly by the user, but they can be referenced by other mappings.

For example, now we could instruct Vim to execute our named mapping when the user presses `cp`.

    nmap <Plug>TransposeCharacters xp
    nmap cp <Plug>TransposeCharacters

This iteration of our custom mapping is twice as long as the previous one, and it behaves exactly the same way. But it lays the foundations to make our mapping repeatable.

## Mapping #3: set up dot command to invoke named mapping

The repeat.vim plugin allows us to tell Vim which mapping to execute when we use the dot command. Let's modify our named mapping so that after running the Normal mode `x` and `p` commands, it calls the `repeat#set()` function, setting up the dot command to repeat this named function. That doesn't fit onto a single line, so let's break it in two:

    #3
    nnoremap <Plug>TransposeCharacters xp
    \:call repeat#set("\<Plug>TransposeCharacters")<CR>
    nmap cp <Plug>TransposeCharacters

I'll save and source this file... Now when I use the `cp` command, not only does it transpose two characters, but it calls the `repeat#set()` command. And now the dot command transposes two characters. Bingo!

## Mapping #4: silence the cmdline output

There's one final improvement that I'd like to make though: let's mute this output at the command line. We can do this by adding the `<silent>` argument to our named mapping:

    #4
    nnoremap <silent> <Plug>TransposeCharacters xp
    \:call repeat#set("\<Plug>TransposeCharacters")<CR>
    nmap cp <Plug>TransposeCharacters

I'll save and source this file... Now our custom `cp` command silently sets itself up to be invoked by the dot command. Nice!

## Outro

If you find yourself frequently using the same two commands in succession, consider using this technique to create a repeatable composite. The dot command can be a real time-saver!
