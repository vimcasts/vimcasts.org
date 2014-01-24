## Open read only version of a file in another branch

Suppose that you are working on a file in one git branch, and you want to refer to the same file in some other branch of the same repository. What are you going to do?

With fugitive, you can use the `Gedit` command to open a file from any branch in a read only buffer.

The branch that I'm currently on has an outdated version of the Gemfile. But I know that the Gemfile on the master branch is up to date.

The general format for reading a file from another branch goes:

    :Gedit branchname:path/to/file

So in this case, I can get what I want by running:

    :Gedit master:Gemfile

Note that I can use auto-completion both for the branch name and for the filepath.

And there we have it: the Gemfile from the master branch.

When you read a file from another branch in this fashion, it is opened in a read-only buffer. If you wanted to make changes to this file, then you would first have to switch to that branch. 

There are variations on `Gedit` that allow you to open the specified file in a split, vertical split, tab, or preview window. If you run any of these commands with no arguments, they will open the working tree version of the current file.

## Exploring the git database with :Gedit

The `:Gedit` command allows you to open a buffer containing any git object. There are 4 kinds of git object:

* blobs - correspond to the content of a file
* trees - correspond to a directory on the filesystem, representing a list of blobs and trees
* commits - can reference a tree and one or more parent commits
* tags - refer to a particular commit by name

Every git object is identified by a SHA identifier. When you run `:Gedit SHA` "Gedit with a SHA id" it will open a  buffer containing a textual representation of the corresponding git object.

To demonstrate, lets run `git log` in the terminal here. This outputs a list of commit objects, in chronological order. Now, if I copy the SHA id for any particular commit, I can switch back to Vim and run the Gedit command, pasting the SHA id from the clipboard:

    :Gedit {SHA}

This opens a buffer containing an overview of the corresponding commit. You can get the same overview at the command line by running:

    git show {SHA}

But when you view a git object like this in Vim, fugitive makes the experience much more interactive. If I place my cursor anywhere on the line referencing the parent commit and press `<Enter>`, it opens a new buffer containing that commit object. I could keep doing this indefinitely, travelling back through the timeline of commits.

But it's not just commit objects that can be explored in this fashion. Watch what happens if I leave the cursor on the line referencing the tree for a particular commit and press the `<Enter>` key. Fugitive opens a buffer with a textual representation of that tree.

Again, I could inspect this tree object at the command line by running:

    git show {SHA}

But when the `git show` command is provided with the SHA id for a tree, the output is not very informative. It shows the *names* of blobs and trees contained in that tree, but if you wanted to know more about these items, you would have to find out their SHA id. You can get more information about the items in a tree by running the command "git ls-tree with the SHA code":

    git ls-tree {SHA}

When you inspect a tree object using fugitive, you can press the `a` key to toggle the display between the `git ls-tree` and the `git show` style listing.

If you wanted to inspect the contents of a blob at the command line, you could run "git show with the SHA code":

    git show {SHA}

But mucking around with SHA identifiers is a bit of a faff.

Now watch this. When you inspect a git tree object using fugitive, each of blobs and files within the tree can be inspected just by placing your cursor on it and pressing `<Enter>`. This makes it really easy to explore what your project looked like at the time of a particular commit.

Having started with a commit object, I've drilled down through several trees and subtrees, and now I'm looking at the contents of a git blob. If I wanted to move back up to look at the parent tree, I could do so by running "edit percent colon H":

    :edit %:h

I've created a mapping for this, so that I can trigger it more easily. Check the shownotes for this episode for more details.

Note that if your current buffer contains a git tree or blob, you can always jump up to the commit object for the current tree by pressing `C` "shift C".

There's one more thing I want to show you. When we've got a commit object inside of a buffer, we get a summary of the patches for each file touched by that commit. Now watch what happens if I place my cursor on the 'diff' line and press the `<Enter>` key. Bang! We get a vimdiff split view. The buffer on the left always represents an older state than the buffer on the right. In this case, the left window represents the how the file looked before this commit, and the window on the right represents how the file looked after the commit.

It's easy to get disoriented when you're exploring the history of your git repository in this way. It's useful to remember that when you're editing a fugitive buffer, running the command:

    :Gedit

with no arguments takes you back to the working tree version of the currently active file.

## Gbrowse

The `:Gbrowse` command lets you inspect the current object on github. The command is pretty smart about doing the right thing depending on the context. Here, I'm editing a file on the master branch, and when I run `:Gbrowse` it opens the corresponding URL. Now if I switch to another branch, and run the command again, it opens the URL for the current file on my new branch.

Check this out: if I make a visual selection, then run the `Gbrowse` command, then the URL will include an anchor for the specified lines, and github automatically highlights them.

FIXME: -current file-

But it doesn't just work for files. Lets open up the parent of the last commit by running "Gedit head carrot":

    :Gedit HEAD^

That opens a new buffer containing the commit object. Now if I run `:Gbrowse` from here, it opens up the URL for that commit object on github.

And watch what happens if I open up the tree for the current commit, then drill down through a couple more trees. When I run `:Gbrowse`, it opens the URL for the current tree on github.

Naturally, if your repository isn't hosted on github, then the `Gbrowse` command won't be able to generate a github URL for it. If this is the case, then fugitive will attempt to open the current object using `git-instaweb`.


## .vimrc mods

### Auto-clean fugitive buffers

Each time you open a git object using fugitive it creates a new buffer. This means that your buffer listing can quickly become swamped with fugitive buffers.

Here's an autocommand that prevents this from becomming an issue:

    autocmd BufReadPost fugitive://* set bufhidden=delete

I'll add that to my .vimrc then restart Vim...

    :Gedit HEAD^

Now I can browse through my commit history, and each time I leave a fugitive buffer it will be deleted automatically. Note that my buffer list only shows the fugitive buffer that is currently active.

### Add git branch to status line

Fugitive provides a function that you can add to your statusline, and it will show your current git branch. The fugitive documentation provides an example, which I'm just going to paste into my .vimrc file:

    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

Now when I open any file from a git repository, the branch name is included in the status line.