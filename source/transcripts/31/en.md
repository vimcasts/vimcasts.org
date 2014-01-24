## Git

The fugitive commands are launched from Vim's command line by typing colon followed by the command name, which always starts with a capital 'G'. The first one to learn is simply 'Git'. This runs any arbitrary git command, with the output echoed below Vim's command line.

If a command generates a lot of output, then I prefer to run it in the terminal. Take `git log` for example. Git automatically pipes the output into a pager, making it easy to read. Whereas if I run `Git log` through fugitive, Vim echoes the output as a stream, which is not so easy to work with.

On the other hand, commands that don't generate much output are fair game for running with fugitive's `:Git` command. For example, I could run:

    :Git checkout -b experimental

This just prints a single line of output to tell me that the command ran successfully. 

Note that if you have any aliases set up in your git configuration, then fugitive's `:Git` command will work just fine with these. I have 'co' aliased to 'checkout', and 'br' aliased to 'branch', and these work just fine with fugitive.

    :Git co master
    :Git br -D exper<tab>

Note too that fugitive provides autocompletion of branch names. Here, when I type `exper` and hit tab, it expands to `experimental`.

On Vim's command line, the `%` symbol is a shorthand for the path of the current file. So, for example, you could run:

    :Git add %

to stage the current file. There are a quite a few git commands that can take a filename as an argument. Git-rm schedules a file for deletion in the next commit; git move can be used to rename a file, and so on. Using the `%` symbol at Vim's command line might be a little quicker than typing the filepath in the shell, but fugitive provides some convenience methods that are analogous to these commands. 

    :Git rm %
    :Gremove

    :Git mv % target_path
    :Gmove target_path

    :Git add %
    :Gwrite

    :Git co %
    :Gread

These convenience methods are shorter because you don't have to explicitly specify the path of the current file. Fugitive works it out from the context. But there are other advantages to using these methods. Lets have a look at each of these in turn.

## Gwrite

Instead of calling `:Git add %`, you can call `:Gwrite` with no arguments, and it will write the current file to the index. We'll see later that this is just one of several ways to stage your work using fugitive.

## Gread

*prep: type `20OWhoops! I made a mess!<esc>`*

Suppose that after doing some work on a file you realise that you've messed up, and you need to revert it to the last checked in version. As long as you haven't already staged the file, you can do this by calling "Git checkout" with the path to the file that you want to revert:

    `:Git checkout %`

Checking out the current file with git reverts the copy on the filesystem, but here in Vim, we already have a buffer open that corresponds to that file. When Vim detects that the version on the filesystem has changed, it prompts us to decide whether to keep our version, or load the updated file from the filesystem.

Fugitive provides a neater way of reverting a file in the form of the `Gread` command. When called with no arguments, this empties the buffer and reads in the contents of the file as it appeared in the last commit. The outcome is just the same as if you had run `:Git checkout %`, but fugitive operates directly on the buffer, rather than on the filesystem, so you don't get interupted by a prompt.

I've demonstrated the most basic use-cases for `Gread` and `Gwrite`. Both of these commands can behave differently depending on the context in which you call them, or if you provide arguments. We'll see some further examples in another episode of Vimcasts.

## Gremove

If you were to run `:Git rm %`, it would delete the current file from the repository, but the corresponding buffer would still be hanging around in Vim. In this scenario, you would want to wipe out the buffer to clean up afterwards.

[I'm just going to restore that file so that I can remove it again.]

Fugitive provides a cleaner alternative. The `:Gremove` command wipes out the buffer and runs `git remove` on the current file, in a single step.

## Gmove

If you were to run:

    git mv original/path destination/path

it would destroy the file at `original/path`, and create a new file at `destination/path` with the same content. If you had the original file open in Vim, then you'd have even more tidying up to do than if the file had been deleted. You'd have to delete the buffer corresponding to the original path, and open a new buffer for the file at its new location.

Running `:Gmove` takes care of all of this in one single command. The file is moved to its new location, and the buffer is renamed to match the new filepath.

Note that when you supply a target path as the argument to the `:Gmove` command, it is interpreted relative to the current file's location. If you start the path with a slash, it will be interpreted as relative to the root of the repository, rather than the root of your filesystem. This makes perfect sense in the context, because `git-move` wouldn't work if you tried to move a file to a location outside of the repository.

## Gcommit

The `Gcommit` command opens a split window containing a commit buffer. You can compose your commit message here, then write and close the buffer to finalize the commit.

For a long time I was happy to run `git commit` in the shell, which would fire up a fresh instance of Vim. But there's one big advantage to keeping everything inside a single Vim instance: auto-completion.

Vim's keyword auto-completion is fuelled by the text contained in all open buffers. If I fire up a fresh instance of Vim in the shell, the keyword auto-completion will only be able to use the words found in that single buffer, which is not a great deal of help.

Whereas in this commit window, keyword auto-completion will be fuelled by the words in every buffer that's open in the current session. So I can write the first few characters of a long method-name (for example), then hit ctrl-n to complete it.

## Gblame

When I run `git blame` with a filepath in the shell, I get to see a copy of the file with annotations showing the last commit that modified each line, along with a timestamp and author. Useful information if you want to know who to blame for the bug that has been driving you crazy all morning! But we can do better than this.

When I call `:Gblame` in Vim, fugitive creates a vertical split and places all of the annotations in the new window. Notice how the window containing the file maintains its syntax highlighting. Also, note that the split windows are bound together, so that if you scroll either one of them, the other window will follow.
