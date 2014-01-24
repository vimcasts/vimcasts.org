--- 
:title: Fugitive.vim - browsing the git object database
:date: 2011/05/13
:tags: fugitive
:poster: /images/posters/fugitive_4.png
:flattr_id: "271805"
:duration: 585
:number: 34
:ogg: 
  :url: http://media.vimcasts.org/videos/34/fugitive_4.ogv
  :size: 23102160
:quicktime: 
  :url: http://media.vimcasts.org/videos/34/fugitive_4.m4v
  :size: 28148709

---

With the fugitive plugin, you're not limited to just working with files in your working tree. The `:Gedit` command allows you to open files in other branches, and to browse any [git object][gito], including tags, commits and trees. Plus, if your repository is hosted on github, you can easily bring up the webpage for any git object using the `:Gbrowse` command.

*This is the penultimate of a five part series on fugitive.vim.*

[gito]: http://book.git-scm.com/1_the_git_object_model.html


READMORE


### Reading a file from any git branch

Fugitive makes it possible to open a *read only* buffer with the contents of any file, on any local git branch. You can do this using the `:Gedit` command followed by an argument of the form: `branchname:path/to/file`. Note that you can use the tab key to auto-complete both the branchname and the filepath.

Remember that the `%` symbol has special meaning on Vim's command line: it is a shorthand for the current file's path. So if you wanted to open the current file on a branch called 'feature', you could do so by running `:Gedit feature:%`.

### Exploring the git object database

The `:Gedit` command allows you to open a buffer containing any git object. There are 4 kinds of git object:

* blobs - correspond to the content of a file
* trees - correspond to a directory on the filesystem, representing a list of blobs and trees
* commits - can reference a tree and one or more parent commits
* tags - refer to a particular commit by name

Every git object is identified by a SHA code. When you run `:Gedit SHA` it will open a buffer containing a textual representation of the corresponding git object. This could be a blob, tree, commit or tag.

### Commit objects

If you run `:Gedit SHA`, passing in the id for a commit object, then fugitive will open a buffer containing a textual representation of that commit. This looks just like the what you see when you run `git show SHA` in the shell, but fugitive makes the buffer interactive in a number of ways. Depending on where your cursor is positioned, pressing the `<Enter>` key can open a new buffer containing another git object.

* press `<Enter>` on a reference to a parent to open that commit object
* press `<Enter>` on a reference to a tree to open that tree
* press `<Enter>` on a diff summary line to diff the specified file before and after that commit

### Tree objects

If you run `:Gedit SHA`, passing the id for a tree object, then fugitive will open a buffer containing a textual representation of that tree. Again, this looks just like what you see when you run `git show SHA` in the shell. But you can get more information in the shell by running `git ls-tree SHA` - this includes the SHA code for every object referenced by that tree.

When fugitive creates a buffer representing a tree object, you can press the `a` key to toggle between the `git show` and `git ls-tree` views.

You can navigate through a fugitive tree buffer just like you would using [Vim's native file explorer][15] (or the NERD tree). Pressing `<Enter>` when your cursor is on a line representing a file or a directory will open a buffer for that object.

The tree buffer makes it easy to drill down through the directories of your git repository, but it's not obvious how you could go up a level to the parent directory. Running the following command will open the parent tree:

    :edit %:h

If you want, you could create a mapping to make this easier. Here's an example, which maps `..` to the above command, but only for buffers containing a git blob or tree:

<pre class="brush: vimscript">
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap &lt;buffer&gt; .. :edit %:h&lt;CR&gt; |
  \ endif
</pre>

Whenever your current buffer contains a git tree or blob, you can always jump up to the commit object for the current tree by pressing `C`.

### Open the github URL for the current object

If your git repository is hosted on github, then you can open the webpage for the current git object by running the `:Gbrowse` command. This is pretty smart about doing the right thing for the context. Whether the active buffer contains a blob, tree, commit or tag, fugitive will generate the appropriate URL.

Also, if you trigger `:Gbrowse` from visual mode in a file, then the selected lines will be highlighted in the github source.

### Auto-clean fugitive buffers

Each time you open a git object using fugitive it creates a new buffer. This means that your buffer listing can quickly become swamped with fugitive buffers.

Here's an autocommand that prevents this from becomming an issue:

<pre class="brush: vimscript">
autocmd BufReadPost fugitive://* set bufhidden=delete
</pre>

### Add git branch to status line

Fugitive provides a function that you can add to your statusline, and it will show your current git branch. This example is taken from the fugitive documentation (`:help fugitive-statusline`):

<pre class="brush: vimscript">
set statusline=%&lt;%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
</pre>

### Further reading

* [The git object model][gito]
* [Browsing git objects][gbr]
* [`:help c_%`][percent]
* [`:help ::h`][colonH]
* [`:help :Gedit`][Gedit]
* [`:help :Gbrowse`][Gbrowse]
* [`:help fugitive-mappings`][mappings]
* [`:help fugitive-statusline`][statusline]

[gito]: http://book.git-scm.com/1_the_git_object_model.html
[gbr]: http://book.git-scm.com/7_browsing_git_objects.html
[colonH]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#::h
[percent]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_%
[15]: /e/15
[Gedit]: http://vim-doc.heroku.com/view?https://raw.github.com/tpope/vim-fugitive/master/doc/fugitive.txt#fugitive-:Gedit
[Gbrowse]: http://vim-doc.heroku.com/view?https://raw.github.com/tpope/vim-fugitive/master/doc/fugitive.txt#fugitive-:Gbrowse
[mappings]: http://vim-doc.heroku.com/view?https://raw.github.com/tpope/vim-fugitive/master/doc/fugitive.txt#fugitive-mappings
[statusline]: http://vim-doc.heroku.com/view?https://raw.github.com/tpope/vim-fugitive/master/doc/fugitive.txt#fugitive-statusline
