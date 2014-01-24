# Resolving merge conflicts with vimdiff

*Setup: create 2 branches with conflicting chages to the same file. Merge one branch into the other, open the conflicted file and run `:Gdiff`.*

I'm currently on a 'feature' branch, where I've made some changes to the demo file. Now I'm going to check out the master branch, where I happen to know that the demo file has also been modified.

    git checkout master
    git merge feature

I'm going to attempt to merge the feature branch back into master. As expected, git advises me that there was a conflict in merging the demo file. We'll have to resolve this conflict by hand.

If we open the working copy of this file, you can see right away that it's conflicted, because git inserts these indicators to show the parts of the file that had been changed in both branches.

    <<<<<<< HEAD:demo.rb
      property :name,             String, :length => 0..555
      property :slug,             String, :length => 0..555
      property :article,          String, :length => 0..50
    =======
      property :name,             String, :length => 0..255
      property :slug,             String, :length => 0..255
      property :article,          String, :length => 0..10
    >>>>>>> sprint:demo.rb

The first hunk is taken from the target branch, and the second hunk comes from the merge branch. I'm going to be using the terms 'target' and 'merge' branch a lot here, so lets make sure we're on the same page.

The 'target' branch is the one that is active when you run git merge. Or in other words, it's the HEAD branch. The 'merge' branch is the one that is named in the `git merge` command. In this scenario the 'master' branch is the target, and the 'feature' branch is merged into target, making it the merge branch

    git co master
    git merge feature

If you run the `:Gdiff` command on a conflicted file, it performs a vimdiff between the working copy and the two conflicting parent versions. This opens up 3 vertical split windows:

* the left window contains the version from the target branch (that is, the branch that was active when we ran `git merge`)
* the middle window contains the working copy of the file, complete with conflict markers
* the right window contains the version from the merge branch

We need to go through each conflict in the working copy, and choose whether to keep the version from the target or merge branch.

If you've ever used vimdiff for a 2 way merge, you'll already know that Vim provides 2 commands for reconciling differences: `diffget` and `diffput`. In the context of a 2-way diff, these commands are unambiguous. If I ask Vim to get the diff from the other window, there is only one place for it to look.

When you do a 3-way merge, things get a little more complex. This time, it would be ambiguous if I was to tell Vim to fetch the changes from the other window. I have to specify which buffer to fetch the changes from by providing a `[bufspec]`.

You can identify a buffer by its name or by the buffer number as it appears when you run:

    :ls

In this case, the buffers are numbered 1, 2 and 5. Buffer numbers are assigned sequentially, so they will differ from session to session, but you can always be sure that they will uniquely identify their buffer.

You can also identify a buffer by its name. A partial match will do, so long as the string provided can be used to uniquely identify the buffer. Fugitive follows a consistent naming convention when creating buffers for the target and merge versions of a conflicted file.

    working copy:
        demo.js
  
    target:
        fugitive:///path/to/project/.git//2/demo.js

    merge:
        fugitive:///path/to/project/.git//3/demo.js

In this case, I can reference the working copy using the buffspec `demo`. The target version can be uniquely identified as `//2`, and the merge version as `//3`. Whereas buffer numbers will vary from session to session, the target and merge branches will always contain these strings.

We'll be using these strings later as bufspecs, so I'll keep these labels visible throughout.

There are two basic strategies for reconciling a 3-way diff. You can either keep your cursor in the middle file, and run `:diffget` with the bufspec for the file containing the change you want to keep.Or you can position your cursor on the change that you want to keep, and run `:diffput` with the bufspec for the working copy file. We'll take a look at each of these strategies in turn, starting with diffget.

## Using `diffget`

Diffget modifies the current buffer by *pulling* a change over from one of the other buffers. We want to update the middle buffer so that each conflict is replaced with the version from either one of the parent branches. That means that we want to keep the middle buffer active, and run `diffget` with a reference to the buffer containing the change that we want to use.

For this conflict, I want to keep the change from the target version - the one on the left, which can be identified by the buffspec `//2`.

    :diffget //2

See what's happened there? The conflict markers have disappeared from the working copy, to be replaced by the corresponding lines from the target version.

The diff highlighting looks out of sync now, so we'll fix it by running:

    :diffupdate

The region of the file that we changed is still highlighted by vimdiff, because there is still a conflict between the working copy and the merge version, but that is to be expected.

In vimdiff mode, you can quickly jump between the conflicting regions by using the square bracket keys followed by the 'c' key:

    ]c - to jump to the next diff
    [c - to jump to the previous diff

We'll jump to the next conflict by pressing `]c`.

This time, we want to keep the change from the merge version - the one on the right, which can be identified by the bufspec `//3`.

    :diffget //3

Again, that replaces the conflict markers in the working copy with the corresponding lines from the specified version.

That's the last of the conflicts in this file, so now we can leave vimdiff mode. To do that, we just need to close all of the windows apart from the middle one containing the working copy. The quickest method is to run the command:

    :only

From there, you can run your tests to check that everything works as it should, and complete the git merge by checking in your changes.

## Using `diffput`

I'm just going to undo those changes, so that we can start off again with a conflicted working copy. This time, we'll try the alternative strategy, using the `diffput` command.

Diffput pushes a change from the *active* buffer into one of the others. In this case, we want to position our cursor on either the target or merge version of the file, and put the change into the working copy.

Lets jump to the first diff by running `]c`. We're going to keep the change from the target version, the one on the left, so we'll make that the active window.

The `diffput` command requires a bufspec to identify where the change is to be sent. Here, we'll use the string 'demo' to reference the working copy of the file:

    :diffput demo

I know that if I run this, it will confuse the vimdiff coloring. So I'm just going to go ahead and run `diffupdate` in the same command:

    :diffput demo | diffup

The 'bar' character here just tells Vim to run the two commands sequentially.

See that? The conflict markers in the working copy have now been replaced by the change underneath the cursor in the active buffer.

### Introduce fugitive-dp

I mentioned earlier that in a 2-way diff, the diffget and diffput commands require no argument. Vim provides a couple of convenient shorthand mappings for these commands: `do` performs a `diffget`, and `dp` does `diffput`.

These mappings don't normally work in a 3-way diff, because the `diffget` and `diffput` commands both require an argument in this context. But in the case of the `diffput` command, it's pretty easy to guess what that argument is going to be. When you do a 3-way diff between working copy, target and merge parents, fugitive assumes that if you run `dp` from either of the parent buffers, you want to put the change into the working copy. So even though the `dp` mapping normally only works in a 2-way diff, you can use it in this special case of a 3-way diff.

Lets jump to the next conflict.

[press `]c`]

This time, we'll keep the change from the merge version - the one on the right. We need to make that the active buffer, by moving the cursor into it. Now, instead of running the `:diffput demo` command again, I'm just going to use the `dp` mapping.

[Note that the `dp` command runs `diffput` followed by `diffupdate`. So if you use this method, the diff coloring won't fall out of step.]

[open the status window]

Our working copy is now conflict free, so we can stage it and commit. In previous episodes in this series, we've seen that the `:Gwrite` command can be used to stage the working copy. Now watch what happens when I run it from the working copy here.

Not only has the file been added to the index, but the 3-way split has vanished, leaving only the working copy buffer. 

## Keeping one parent version in its entirety

[Leave the status window open, and run the commands:

    :Git reset --hard
    :Git merge feature
]

In the examples so far, we've assumed that both conflicting parents contain changes that are to be kept. In reality, it's often the case that one of the parent versions is to be kept wholesale, and the other file is to be discarded.

In this scenario, fugitive's `:Gwrite` command comes in handy. This overwrites the working tree and index copies with the contents of the currently active file. 

Suppose that I want to keep the merge version - the one on the right - I'll just make that the active window. Now, if I try running the `Gwrite` command in the usual fashion, Vim issues a warning.

If I had just spent the last 5 minutes carefully cherry-picking changes from the target and merge versions, then I would be pretty upset if I accidentally overwrote the working copy and index with one of the parent versions. So when we run `Gwrite` from either the target or merge parent, we have to add a trailing exclamation mark to show that we really mean it.

    :Gwrite! [bang]

Bang! The merge version of the file overwrites the working copy, and adds it to the index. The file is no longer marked as 'conflicted', and is ready to be committed.
