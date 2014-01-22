## Gstatus

*Setup: prepare git repository by making changes to at least 5 files, to demonstrate adding/removing these from the index. Add a method called reallyLongMethodName to demonstrate autocompletion.*

Fugitive provides a `:Gstatus` command, which opens up a window showing the status of the files in your working directory. The contents of this window look just like the output you see on the command line when running `git status`. But fugitive enhances this window by making it interactive.

As in any Vim buffer, you can move down and up with the `j` and `k` keys. But there's a quicker way: if you press `ctrl-n` or `ctrl-p`, you'll move down and up directly between filenames, skipping the blank lines in between.

### Add and reset files with `-`

If you position your cursor on a file that hasn't been staged and press the `-` key, fugitive will run `git add` on that file, adding it to the index. If the cursor is positioned on a file that has been staged, the `-` key will instead run `git reset` on that file, removing it from the index.

The `-` key also works in visual mode, so if you select several lines then you can add them all to the index by pressing `-` just once.

Just because you can use the `-` key to add files to the index doesn't mean that you should. If you have a large list of files with changes and you want to add all of them to the index, you're much better off just running:

    :Git add .

Note that the status window automatically updated when I ran this.

### Add patches from a changed file

From the status window, you can trigger `git add --patch` for the file under the cursor by pressing the 'p' key. This splits your file into hunks of changes, and allows you to select which ones are to be added to the index.

In Macvim the output is not colored, but in the shell patches are color coded, and for this reason I prefer to run this command from the shell.

But as we'll see shortly, fugitive provides an alternative way of staging hunks to the index using the `Gdiff` command in combination with Vim's built in vimdiff functionality.

### Review a changed file

If you press the enter key in the status window, the file under the cursor will be opened in the window beneath. This makes it really easy to review a file before checking it in. If I then run the `Gdiff` command, it will perform a vimdiff on the file, splitting the window and allowing you to compare the working copy with the version in the index.

The appearance of vimdiff will depend on which colorscheme you have installed. Here, I'm using the solarized theme, which uses green to represent lines that have been added, and red for lines that have been removed.

### Commit

At any time, you can open a commit window by running the `:Gcommit` command. But in the context of the status window, pressing `C` "shift-c" is a shortcut for the same.

# Working with the git index

The git index is where you put changes that you want to be included in the next commit. If you are used to working with the command line git client, you might think of the index as an abstract concept. But with fugitive, you can actually read the index version of a file into a buffer.

To make this possible, fugitive does some clever things with git plumbing. You don't need to understand what goes on behind the scenes. You just need to know that running "gedit colon followed by the filepath"

    :Gedit :path/to/file

will open the index version of the specified file. You can always open the index version of the current file by running "gedit colon 0".

    :Gedit :0

It helps to understand the lifecycle of the index file between two commits. To begin with, the contents of the index and working copy files will be exactly the same as the most recent commit. As you make changes to your working copy, its contents begin to diverge from those of the index file. Staging a file updates the contents of the index file to match those of the working copy. When you commit your work, it is the contents of the index file that are saved with that commit object.

## Wholesale reconciliation with :Gwrite

*Setup: make 2 unrelated sets of changes to a file. Make sure changes include code added and removed. When opening vimdiff, switch off folding.*

If you run `:Gdiff` in a working tree file, fugitive will perform a vimdiff against the working copy of the current file and the version in the index. This gives you a split window view of the current file with the working tree version on the right, and the index version on the left. The two files always appear side by side in that order, so you can commit that to memory.

I'm going to keep the status window open in the top split here, so that we can keep track of our progress.

If I wanted to stage all changes in this file, I could do it by running the:

    :Gwrite

command from the working copy. This writes the contents of the working copy into the index file. As a result, these split windows are now identical, and the status window shows that the changes have been staged.

I'm just going to switch to the index file and undo that change.

Now watch what happens if I run the `:Gwrite` command from inside the index file. This time, the contents of the *index* file overwrite the *working copy*. Remember, the index file represents the last commited version of the file. So overwriting the working copy with those contents is the same as undoing all of your changes. Note that the status window now indicates that there are no changes in the repository.

Running `:Gwrite` from the index file has the same effect as running `:Gread` from the working copy. Both cause the working copy to revert to the index version. There's a certain symmetry to these two commands, so you can probably anticipate that running `:Gread` in the index file has the same effect as running `:Gwrite` in the working copy - that is, to stage the changes.

I find it most intuitive when running commands from the working copy, but it does help to understand the options that are available.

## Piecemeal reconciliation with :diffget/:diffput

The `:Gread` and `write` commands reconcile differences between the index and working copy by overwriting the contents of one buffer with the other. But we can be much more granular about reconciling differences if we use Vim's built in `diffget` and `diffput` commands.

We'll start off by making the index file active, then position the cursor on the change that we want to reconcile. This hunk of text was deleted in the working copy. If I position my cursor on the green text in the index file and run `:diffget`, it pulls across the change from the working copy, deleting that hunk of text from the index file. Now there are no differences between the working copy and the index for this region of the file, so the red/green highlighting disappears.

Notice the `[+]` symbol in the status line for the index file? This indicates that the buffer has been changed, but not saved. Now I'm going to save the index file, and I want you to keep an eye on the status window as I do it.

See that? The file is now listed twice in the status window. This means that some changes have been staged, while others are in the working copy but not in the index. If we run `git diff --cached` at the command line, we get a patch showing the current changeset for the index. This confirms that we've staged a single hunk of changes.

Here's another section that has been deleted from the working copy. We have a contiguous range of lines, but I only want to include some of these in this commit. If I run the `diffget` command in visual mode, then only the selected range of changes will be pulled into the current file. In this case, the change is a deletion, so the selected lines are deleted from the index.

[select contiguous lines, and run `:diffget`]

Judging by the way the colors look now, it seems that I've confused vimdiff. If this happens, you can tell Vim to update the diff highlighting by running:

    :diffupdate

If I save the index file and run `git diff --cached` in the terminal, the patch shows that only the lines I specified have been removed from the index. It wouldn't be easy stage a subset of contiguous changes using the interface to `git add --patch`, so this is one place where fugitive really shines.

Let's stage another change, this time using a hunk that *added* text to the working copy. The text that was added to the working copy is highlighted in green, and the corresponding position in the stage file is highlighted in red. Watch this: I can't position the cursor anywhere on the red lines. After all, they represent a hunk of text that doesn't exist in the index file. Instead, I'll position the cursor on the line after.

Instead of typing the `:diffget` command, I'm going to use the shorthand form: `do` (which stands for "diff obtain"). That has pulled the hunk of text across from the working copy into the index buffer. When I save this and run `git diff cached`, that text appears in the patch.

Suppose that I wanted to stage a subset of lines that were *added* to the working copy. Here, the `diffget` command is no use, because I can't select a range of absent lines. Instead, I'll have to switch to the working copy of the file, where I can select the range of lines that I want to add to the index. Instead of running `diffget`, this time I'll use the `diffput` command, which writes the selected lines into the other window.

Personally, I find that the `diffget` command is more intuitive, because it changes the currently active buffer. Whereas the `diffput` command feels less intuitive to me, because it affects a change in the inactive buffer. But there is a certain symmetry between the put and and get commands, so it helps to understand how both of them work.

We saw earler that the `:Gread` and `:Gwrite` commands can either add a file to the index or reset the file, depending on where they are called from. The same can be said for `:diffget` and `:diffput`, except that these operate at a more granular level.

I won't demonstrate every permutation of the matrix here, but I suggest that you try running each command in both the index and working copy files, until you get a feel for it.

In the next episode, we'll learn how to resolve a merge conflict by performing a 3-way vimdiff. 
