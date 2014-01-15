--- 
:title: Fugitive.vim - exploring the history of a git repository
:date: 2011/05/18
:poster: /images/posters/fugitive_5.png
:flattr_id: "277398"
:duration: 604
:number: 35
:ogg: 
  :url: http://media.vimcasts.org/videos/35/fugitive_5.ogv
  :size: 26702522
:quicktime: 
  :url: http://media.vimcasts.org/videos/35/fugitive_5.m4v
  :size: 32349589

---

Git provides tools for searching the contents of files, commit messages, and even whether text was added or removed by a commit. In this episode, we'll see how fugitive's `Ggrep` and `Glog` commands wrap this functionality up so that we can search the contents and history of a git repo from right inside of Vim.

*This is the last of our five part series on fugitive.vim.*


READMORE

<r:snippet name="announcement"/>

### Browsing past revisions of a file

The `Glog` command makes it easy to examine all previous revisions of a file. It does this by loading each revision into its own buffer, and queuing them in the quickfix list in chronological order.

You can filter the results 

<table class="fullwidth">
  <tr>
    <th class="command">command</th>
    <th>action</th>
  </tr>
  <tr>
    <td>
      <code>:Glog</code>
    </td>
    <td>load all previous revisions of the current file into the quickfix list</td>
  </tr>
  <tr>
    <td>
      <code>:Glog -10</code>
    </td>
    <td>load the last ten previous revisions of the current file into the quickfix list</td>
  </tr>
  <tr>
    <td>
      <code>:Glog -10 --reverse</code>
    </td>
    <td>load the first ten revisions of the current file into the quickfix list (in reverse chronological order)</td>
  </tr>
  <tr>
    <td>
      <code>:Glog -1 --until=yesterday</code>
    </td>
    <td>load the last version of the current file that was checked in before midnight last night</td>
  </tr>
</table>

### Browsing past commits

You can also use the `:Glog` command to review past commit objects, by appending a trailing `--` argument. By default, this will load all ancestral commit objects into the quickfix list. If you supply a filepath after the `--` argument, then the list will be filtered to only include commit objects that touched the specified file.

<table class="fullwidth">
  <tr>
    <th class="command">command</th>
    <th>action</th>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;--</code>
    </td>
    <td>load all ancestral commit objects into the quickfix list</td>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;-- %</code>
    </td>
    <td>load all ancestral commit objects that touched the current file into the quickfix list</td>
  </tr>
</table>

Note that when fugitive loads a commit object into a buffer, it is interactive in a number of ways. See [episode 34][34] for more details.

### Working with the quickfix list

I recommend installing [unimpaired.vim][], another plugin by Tim Pope. This provides lots of useful pairs of mappings, including a handful that make working with the quickfix list much easier:

<table class="fullwidth">
  <tr>
    <th>unimpaired</th>
    <th>Vim</th>
    <th>action</th>
  </tr>
  <tr>
    <td><code>[q</code></td>
    <td><code>:cprev</code></td>
    <td>jump to previous quickfix item</td>
  </tr>
  <tr>
    <td><code>]q</code></td>
    <td><code>:cnext</code></td>
    <td>jump to next quickfix item</td>
  </tr>
  <tr>
    <td><code>[Q</code></td>
    <td><code>:cfirst</code></td>
    <td>jump to first quickfix item</td>
  </tr>
  <tr>
    <td><code>]Q</code></td>
    <td><code>:clast</code></td>
    <td>jump to last quickfix item</td>
  </tr>
</table>


### Searching the working tree with `Ggrep`

The `Ggrep` command is a wrapper for `git grep`. It uses the results to populate the quickfix list, so you can easily navigate the result list from inside Vim.

If you want to search your working tree for the text 'find me', simply run:

    :Ggrep 'find me'

The `git grep` command only looks inside files that are tracked by the git repository. The fact that it only looks inside tracked files means that it skips over any files or directories listed in the `.gitignore` file.

### Searching branches, tags and commits with `Ggrep`

`git grep` is not just limited to reading files on the filesystem. It can look inside any git object. So using `git grep`, you can search all files in any of your git branches without first having to switch to the branch.

<table class="fullwidth">
  <tr>
    <th class="command">command</th>
    <th>action</th>
  </tr>
  <tr>
    <td>
      <code>:Ggrep&nbsp;findme</code>
    </td>
    <td>search for 'findme' in working copy files (excluding untracked files)</td>
  </tr>
  <tr>
    <td>
      <code>:Ggrep&nbsp;--cached&nbsp;findme</code>
    </td>
    <td>search for 'findme' in the index</td>
  </tr>
  <tr>
    <td>
      <code>:Ggrep&nbsp;findme&nbsp;branchname</code>
    </td>
    <td>search for 'findme' in branch 'branchname'</td>
  </tr>
  <tr>
    <td>
      <code>:Ggrep&nbsp;findme&nbsp;tagname</code>
    </td>
    <td>search for 'findme' in tag 'tagname'</td>
  </tr>
  <tr>
    <td>
      <code>:Ggrep&nbsp;findme&nbsp;SHA</code>
    </td>
    <td>search for 'findme' in the commit/tag identified by SHA</td>
  </tr>
</table>

When you open a file that belongs on another branch, fugitive will automatically create a *read only* buffer for it.

### Searching for text in a commit message

If you want to search the text of commit messages, you can do so by passing the `--grep` option to the `git log` command. For example, if you wanted to find commit messages containing the text 'findme', you could run:

    git log --grep=findme

You can also do this from inside of Vim using the `:Glog` wrapper. This table summarizes a couple of ways you might use this:

<table class="fullwidth">
  <tr>
    <th class="command">command</th>
    <th>action</th>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;--grep=findme&nbsp;--</code>
    </td>
    <td>search for 'findme' in all ancestral commit messages</td>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;--grep=findme&nbsp;--&nbsp;%</code>
    </td>
    <td>search for 'findme' in all ancestral commit messages that touch the currently active file</td>
  </tr>
</table>

### Searching for text added or removed by a commit

Git also makes it possible to [search for text that was added or removed by a commit using the pickaxe option][pickaxe]. This is activated with the `-S` switch as follows:

    git log -Sfindme

This tells git to go through every commit, comparing the before and after state of *each file* that was changed by that commit. If the specified string is present in the file before, but absent from the file after the commit, then it counts as a match. The converse is also true, so if the specified string was either added or removed by the commit, then it will appear the git log results.

Here are a couple of examples demonstrating how the pickaxe option can be used with `:Glog`:

<table class="fullwidth">
  <tr>
    <th class="command">command</th>
    <th>action</th>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;-Sfindme&nbsp;--</code>
    </td>
    <td>search for 'findme' in the diff for each ancestral commit</td>
  </tr>
  <tr>
    <td>
      <code>:Glog&nbsp;-Sfindme&nbsp;--&nbsp;%</code>
    </td>
    <td>search for 'findme' in the diff for each ancestral commit that touches the currently active file</td>
  </tr>
</table>



### Further reading

* `:help :Glog`
* `:help :Ggrep`
* [`man git-grep`][git-grep] (also, `git help grep`)
* [`man git-log`][git-log] (also, `git help log`)
* [`man gitdiffcore`][gitdiffcore]
* [the git *pickaxe*][pickaxe]
* [Browsing Commits in Vim with an Unimpaired Fugitive][uf]
* [Fun with "git grep"][g1]
* [Fun with "git log --grep"][g2]
* [Linus's ultimate content tracking tool][g3]

[g1]: http://gitster.livejournal.com/27674.html
[g2]: http://gitster.livejournal.com/30195.html
[g3]: http://gitster.livejournal.com/35628.html
[rambling]: http://stopwritingramblingcommitmessages.com/
[unimpaired.vim]: http://www.vim.org/scripts/script.php?script_id=1590
[git-grep]: http://www.kernel.org/pub/software/scm/git/docs/git-grep.html
[git-log]: http://www.kernel.org/pub/software/scm/git/docs/git-log.html
[gitdiffcore]: http://www.kernel.org/pub/software/scm/git/docs/gitdiffcore.html
[pickaxe]: http://www.kernel.org/pub/software/scm/git/docs/gitdiffcore.html#_diffcore_pickaxe_for_detecting_addition_deletion_of_specified_string
[34]: /e/34
[uf]: http://mshared.tumblr.com/post/3215710879/browsing-commits-in-vim-with-an-unimpaired-fugitive