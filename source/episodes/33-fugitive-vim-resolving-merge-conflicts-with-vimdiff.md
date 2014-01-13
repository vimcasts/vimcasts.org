--- 
:title: Fugitive.vim - resolving merge conflicts with vimdiff
:date: 2011/05/06
:poster: /images/posters/fugitive_3.png
:flattr_id: "184250"
:duration: 695
:ogg: 
  :url: http://media.vimcasts.org/videos/33/fugitive_3.ogv
  :size: 17760378
:quicktime: 
  :url: http://media.vimcasts.org/videos/33/fugitive_3.m4v
  :size: 23831068

---

When git branches are merged, there is always the chance of a conflict arising if a file was modified in both the target and merge branches. You can resolve merge conflicts using a combination of fugitive's `:Gdiff` command, and Vim's built in `diffget` and `diffput`. In this episode, we'll find out how.

*This is the third in a five part series on fugitive.vim.*

READMORE

<r:snippet name="announcement"/>

### `:Gdiff` on a conflicted file opens 3-way diff

When you run `:Gdiff` on a conflicted file, fugitive opens 3 split windows. They always appear in this order:

* the left window contains the version from the target branch
* the middle window contains the working copy of the file, complete with conflict markers
* the right window contains the version from the merge branch

![3-way vimdiff splits](/images/blog/3-way-vimdiff.png)

I discuss *target* and *merge* branches a lot in the screencast, so lets just make sure that we're on the same page. The 'target' branch is the one that is active when you run git merge. Or in other words, it's the HEAD branch. The 'merge' branch is the one that is named in the `git merge` command. In this scenario the 'master' branch is the target, and the 'feature' branch is merged into target, making it the merge branch.

![Target and merge branches](/images/blog/target-merge-branches.png)

### Strategies for reconciling 3-way diffs

There are two basic strategies for reconciling a 3-way diff. You can either keep your cursor in the middle file, and run `:diffget` with the bufspec for the file containing the change you want to keep. Or you can position your cursor on the change that you want to keep, and run `:diffput` with the bufspec for the working copy file. We'll take a look at each of these strategies in turn, starting with diffget.

![3-way reconciliation strategies](/images/blog/3-way-reconciliation.png)

### Introducing buffspecs

In the context of a 2-way diff, the `:diffget` and `:diffput` commands are unambiguous. If you ask Vim to get the diff from the other window, there is only one place for it to look. When you do a 3-way merge, things get a little more complex. This time, it would be ambiguous if you were to tell Vim to fetch the changes from the other window. You have to specify which buffer to fetch the changes from by providing a `[bufspec]`.

The buffspec could either be the buffer number, or a partial match for the buffer's name. Buffer numbers are assigned sequentially, so they will differ from session to session, but you can always be sure that they will uniquely identify their buffer.

Fugitive follows a consistent naming convention when creating buffers for the target and merge versions of a conflicted file. The parent file from the *target branch* always includes the string `//2`, while the parent from the *merge branch* always contains `//3`. These partial matches are sufficient to uniquely identify the target and merge parents when using the `:diffget` command.

<table>
  <tr>
    <th>parent version</th>
    <th>buffspec</th>
  </tr>
  <tr>
    <td>target</td>
    <td><code>//2</code></td>
  </tr>
  <tr>
    <td>merge</td>
    <td><code>//3</code></td>
  </tr>
</table>


### Resolving a 3-way diff with `:diffget`

The `:diffget` command modifies the current buffer by *pulling* a change over from one of the other buffers. In resolving a merge conflict, we want to treat target and merge parents as reference copies, pulling hunks of changes from those into the conflicted working copy. That means that we want to keep the middle buffer active, and run `diffget` with a reference to the buffer containing the change that we want to use. 

* `:diffget //2` - fetches the hunk from the target parent (on the left)
* `:diffget //3` - fetches the hunk from the merge parent (on the right)

Note that Vim does not automatically recalculate the diff colors after you run `:diffget`. You can tell Vim to do this by running `:diffupdate`.

### Resolving a 3-way diff with `:diffput`

The `:diffput` command modifies another buffer by *pushing* a change from the active buffer into it. In the context of a 3-way merge conflict, we want to push changes from the target and merge versions into the working copy.

The example in the video used a file called `demo.js`, which could be referenced using the buffspec *'demo'*. In this case, we could run the exact same command each time:

* `:diffput demo` - pushes the hunk from the active buffer into the conflicted working copy

Although the command is kept constant, we have to activate the correct window before running it. Whereas using `diffget`, the window remained constant but we had to pass a different argument each time.

In a 2-way diff, the diffget and diffput commands require no argument. Vim provides a couple of convenient shorthand mappings for these commands: `do` performs a `diffget`, and `dp` does `diffput`. These mappings don't normally work in a 3-way diff, because the `diffget` and `diffput` commands both require an argument in this context. But in the case of the `diffput` command, it's pretty easy to guess what that argument is going to be.

When you do a 3-way diff between working copy, target and merge parents, fugitive assumes that if you run `dp` from either of the parent buffers, you want to put the change into the working copy. So even though the `dp` mapping normally only works in a 2-way diff, you can use it in this special case of a 3-way diff.

### Keeping one parent version in its entirety

In reality, it's often the case that one of the parent versions is to be kept wholesale, and the other version is to be discarded. In this scenario, fugitive's `:Gwrite` command comes in handy. This overwrites the working tree and index copies with the contents of the currently active file.

If you run `:Gwrite` from the target or merge version of a file, fugitive raises a warning. This is to protect you from accidentally overwriting the working copy and index files when you've carefully cherry picked the changes from the parent versions. If you want to stage either of the parent versions in their entirety, use `:Gwrite!` to show you really mean it.

### Useful commands

This table summarizes some of the commands used in the video:

<table>
  <tr>
    <th>command</th>
    <th>effect</th>
  </tr>
  <tr>
    <td><code>[c</code></td>
    <td>jump to previous hunk</td>
  </tr>
  <tr>
    <td><code>]c</code></td>
    <td>jump to next hunk</td>
  </tr>
  <tr>
    <td><code>dp</code></td>
    <td>shorthand for `:diffput`</td>
  </tr>
  <tr>
    <td><code>:only</code></td>
    <td>close all windows apart from the current one</td>
  </tr>
  <tr>
    <td><code>:Gwrite[!]</code></td>
    <td>write the current file to the index</td>
  </tr>
</table>

The `dp` command normally only works in a two-way diff, as does `do`: the shorthand for `diffget`. 

To leave *vimdiff* mode, you just need to close the windows that are being compared. The quickest way to do this is to run `:only` from the window that you want to keep open.

When you call `:Gwrite` from vimdiff mode, it writes the current file to the index and exits vimdiff mode.

### Further reading

* [`:help 08.7`][8.7]
* [`:help diff.txt`][diff]
* [`:help :diffget`][diffget]
* [`:help :diffput`][diffput]
* [`:help [c`][nc]
* `:help :Gdiff`
* [Painless Merge Conflict Resolution in Git][painless]


[gdiff]: https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt#L128-135
[32]: http://vimcasts.org/e/32
[8.7]: http://vimdoc.sourceforge.net/htmldoc/usr_08.html#08.7
[diff]: http://vimdoc.sourceforge.net/htmldoc/diff.html
[diffput]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffput
[diffget]: http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffget
[nc]: http://vimdoc.sourceforge.net/htmldoc/diff.html#jumpto-diffs
[painless]: http://blog.wuwon.id.au/2010/09/painless-merge-conflict-resolution-in.html
