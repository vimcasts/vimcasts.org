## Reviewing the history of a file

### Queueing past revisions of a file

The `Glog` command makes it easy to examine all previous revisions of a file. It does this by loading each revision into its own buffer, and queing them in the quickfix list in chronological order.

When I run `:Glog`, the active window switches to the most recently checked in version of the current file. I can go back in time through previous revisions by running `:cnext`. Notice that each time I switch to another revision, I get a summary line showing the first line of the commit message for that revision.

If you are not already using [unimpaired.vim][], another plugin from Tim Pope, then I recommend installing it. It provides 4 mappings that make working with the quickfix list much easier:

    [q - :cprevious
    ]q - :cnext
    [Q - :cfirst
    ]Q - :clast

With these mappings, I can jump to the oldest revision by pressing `]Q` "close bracket big Q", and work my way forwards or backwards through history with the corresponding "square-bracket little-q" mappings.

If I want to return to my working copy, I can do so at any time by running the `:Gedit` command with no arguments.

### Filtering the results

If your project has a long history, then you might want to provide additional arguments to limit the number of revisions that are loaded. For example, running "gee-log minus ten":

    :Glog -10

will only load the last 10 revisions of the current file into the quickfix list. You can also switch the order using the `reverse` option. So running "gee-log minus ten double-dash-reverse":

    :Glog -10 --reverse

only shows the *first* 10 revisions of the current file. You might also want to limit the results to a particular date range, which you can do using the since and until options. For example, running:

    :Glog -1 --until=yesterday

Would load yesterday's version of the current file. More specifically, it would load the last version that was checked in before midnight.

### Queueing commit objects

Note that if you run `git log` in the shell, you get a summary list of commit messages. On the surface, it looks as though the default `:Glog` behaviour has little resemblence to the `git log` command, but it can be easily tweaked. If you supply a trailing `--` "double-dash", then fugitive will queue a list of commit buffers into the quickfix list.

I'm just going to open the quickfix window so that we can see each record, then I'll jump to the oldest commit. As you can see, the `Glog` command has loaded every ancestral commit for the current branch.

A useful variation on this is to provide the path to a file after the double dash argument. On Vim's command line, the percent symbol always represents the path of the current file. So if I run "gee-log double-dash percent":

    :Glog -- %

then fugitive will only queue the commit objects that touched the current file.

## Searching a git repository

A git repository can hold a terrific amount of information about a codebase. If you want to search the repository for a particular query string, there are a handful of ways that you might want to focus the task:

* You could search the working copy. Since this is stored as regular files on the file system, you can use plain old grep or a similar tool to search their contents.
* Alternatively, you might want to search the history of the repository for text contained in commit messages.
* You might also want to search through all changesets for text that was added or removed by a particular commit.

Git provides the tools for each of these, so lets look at each one in turn.

### Searching the working copy

**PREP: concoct a grep command that returns results from inside of the .git directory. Do the same search with `git grep` to prove that it's less noisy.**

Here, I'm going to use grep to search the vimcasts repository for the word 'fugitive'.

    grep -r fugitive * | view -

You can see at a glance that the results include matches from a SQL file. There are other matches in there that are useful, but as far as I'm concerned, the SQL file is just noise. I could fix this by adding an option to the grep command so that it doesn't look inside SQL files:

    grep -r --exclude="*.sql" fugitive * | view -

Not only does this reduce the noise in the results list, but it will speed up the search because it cuts down the number of files that grep has to look inside of.

Git provides it's own variation of the grep command, which searches all files that are tracked by the repository. The fact that it only looks inside tracked files, means that it will skip any files or directories that are listed in the `.gitignore` file. I've got a wildcard in mine that tells git to ignore any SQL files. So if I run the equivalent search using `git grep`:

Git provides it's own variation of the grep command, which understands implicitly that it shouldn't look inside any files or directories that are listed in the `.gitignore` file. I've got a wildcard in mine that tells git to ignore any SQL files. So if I run the equivalent search using `git grep`:

    git grep fugitive * | view -

it automatically skips the SQL file. By default, `git grep` returns more relevant results than plain old grep.

Fugitive provides a wrapper for the `git grep` command, called `:Ggrep`, which collects the search results in the quickfix window. So if you want to search your working tree for a pattern, you can run "gee-grep with the search string" from inside of Vim:

    :Ggrep fugitive

Then you can open up the quickfix window (`:copen`) to view the results.

### Searching any git tree (branches, commits and tags)

`git grep` is not just limited to reading files on the filesystem. It can look inside any git object. So using `git grep`, you can search all files in any of your git branches without first having to switch to the branch. Here, I'm searching for the text 'find me' on a branch called 'demo':

    :Ggrep 'find me' branchname

When you open a file that belongs on another branch, fugitive will automatically create a *read only* buffer for it.

You can also search the files from a particular tag or commit, by providing the tagname or SHA code that identifies them:

    :Ggrep 'find me' SHA

Even if you never find yourself having to search inside commits or tagged snapshots of your repository, the speed and convenience of the `Ggrep` command make it a compelling alternative to ack and plain old grep.

### Searching for text in a commit message

There might be times when you want to search the text of commit messages, rather than the contents of files. Remember that running `git log` in the shell outputs a list of commit messages? Well, if you pass the "double-dash grep" option, then you can filter the list to only show commits whose message includes the specified words:

    git log --grep='xtype'

Of course, we can also run this inside of Vim using the `Glog` wrapper. Note that here I am also *appending* the double-dash argument, so that fugitive will queue commit objects in the quickfix list:

    :Glog --grep='xtype' --

When I ran this in the shell, I got a summary list of commit objects. But when I run it inside of Vim, fugitive creates a *commit buffer* for each match. These commit buffers are interactive, and contain a good deal of information. I showed how to browse the git object database with fugitive in Episode 34.

We've seen the word 'grep' in a couple of different contexts here, so lets just review them to make sure we don't get them mixed up. First, there was the `git grep` command (and it's wrapper, `Ggrep`), which looks inside files and blobs for the specified text. Then we saw `--grep` "double-dash grep" being passed as an option to the `git log` command, which filtered the output of that command.

### Searching for text added or removed by a commit

**PREP: find/create a small project that uses jQuery. Add a jQuery plugin in one commit, then remove it in another commit. Do a pickaxe search for the name of the jQuery plugin.**

What if you want to find some text that used to be present in the project, but has since been deleted? This is where the affectionately named *pickaxe* operator comes in handy. 

This tells git to go through every commit, comparing the before and after state of *each file* that was changed by that commit. If the specified string is present in the file before, but absent from the file after the commit, then it counts as a match. The converse is also true, so if the specified string was either added or removed by the commit, then it will appear the git log results.

To demonstrate, I've just made a commit that *uninstalled* a pagination plugin, therefore removing many occurences of the word 'paginate'. When I run "git log dash-big-S paginate":

    git log -Spaginate

the result list only includes commits that added or removed the word 'paginate'. Unsurprisingly, the list includes the commit where the plugin was installed, and the one where the plugin was removed, and a few others besides.

Again, we can use this option in combination with the `Glog` wrapper to get the results right inside of Vim in a useful format. Here, I'm going to run the same `git log` command from inside Vim:

    :Glog -Spaginate --

which creates a buffer for each commit object, and queues them in the quickfix list for easy traversal.
