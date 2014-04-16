--- 
:title: The Fugitive Series - a retrospective
:date: 2011/05/18
:tags: plugins, git
---

*Fugitive.vim: a git wrapper so awesome, it should be illegal.* That's how Tim Pope describes his git plugin for Vim. I've had [fugitive.vim][] installed since it was released, but until recently I never took the time to figure out what was *so awesome* that could make it illegal.

[fugitive.vim]: http://www.vim.org/scripts/script.php?script_id=2975


READMORE

### Who needs a git wrapper?

Since I started using git a few years ago I've been happy to use the command line client. There's always a terminal window open, and it never felt too arduous to switch to it to run a couple of git commands. This is fine for most of the commands that I run day to day, but occasionally I would want to do something that felt as though it belonged inside of my editor, rather than on the command line. For example, suppose I wanted to find out which idiot was responsible for a particular line of code. I just want to think the thought: 'Who do I blame?', and to see their name right next to it.

I can get this information using the command line client, but it requires a bit of leg work. First, I have to recall the name and path of the file that I am working on, so that I can pass it as an argument to the `git blame` command. Then I need to navigate the output to find the line that I was looking at. The information is there, but it's in a plain text format so I don't get the syntax highlighting that I'm used to.

So `git blame` always struck me as in ideal candidate for integrating with the editor. Sure enough, fugitive provides a `Gblame` command, which does exactly what I want. I don't have to recall the filepath of the current file, because the editor knows it. I don't have to navigate to the current line, because I'm already there. I just have to run the `Gblame` command, and bang! I get the author's name right next to the line of code. Then I have to rap my own knuckles when git tells me I have only myself to blame.

### Digging deeper

I rarely need to use `Gblame`, and the command line client was always good enough for most of the tasks that I perform daily with git. So for too long, I had fugitive installed, but didn't use it. I always had a nagging feeling that I was missing out. After all, Tim Pope says:

> I'm not going to lie to you; fugitive.vim may very well be the best Git wrapper of all time.

I decided that it would be worth digging deeper and sharing what I learned here on Vimcasts. Before long, I realized that it would take at least five episodes to do the plugin justice. There is so much good stuff in there.

I had to level up on git in order to understand some of the cleverness that makes fugitive work. Lets face it though, there's always more to learn about git. As I got a feel for it, I started having crazy ideas: *what if fugitive could do X?* Then I'd try it out, and realize that fugitive *already does* X. There were [girly squeals of joy][squeal].

I couldn't think of any other git commands that were so well suited to running from inside the editor as the `Gblame` example I gave above. Turns out that was just down to a lack of imagination on my part. Fugitive.vim is as bad as its author claims. I think it already is illegal in some states.

I wasn't able to cover everything, but I picked what I think are the choicest cuts. Here follow some of the highlights from the series.

### 1) [A complement to command line git][1]

Commands such as `Gremove` and `Gmove` map directly to `git rm` and `git mv`. I wasn't sold on these at first, because I didn't mind using the git commands. But things can get a little messy if you run these commands in the shell when the files that you act upon are already open in your text editor. For example, if you run:

    git mv original/path.txt destination/path.txt

When you switch back to your editor, you might end up with a window open trying to edit the `original/path.txt` file, which no longer exists. Using the `Gmove` command keeps things tidy, because it simultaneously handles the git index and Vim buffers. Learn more in [part one][1].

### 2) [Working with the git index][2]

I've always had a bit of a fuzzy idea of what the git index is. Perhaps that's because the `.git/index` file uses a binary format, making it look like impenetrable gibberish if you attempt to read it in a text editor. But this is where fugitive gets really clever. Using a handful of esoteric git plumbing commands, fugitive makes it possible to view the indexed version of any file tracked by the repository. Not only can you read the indexed version of a file, but you can run `Gdiff` to compare it with the working copy. Vim's diff mode makes it possible to interactively stage hunks of changes, like when you run the `git diff --patch` command in the shell. Learn more in [part two][2].

### 3) [Resolving merge conflicts with vimdiff][3]

For [part three][3] we stay on the theme of Vim's diff mode. This time, looking at how to manage a 3-way diff to resolve merge conflicts. I usually dread having to deal with git merge conflicts, but having gained a better understanding of my tools, I'm now [looking forward to my next merge conflict][lookforward]!

### 4) [Browsing the git object database][4]

I've often thought that [github][] provided the superlative interface for browsing a git repository. They have a URL for every git object, including trees, blobs, tags and commits.

Well, fugitive makes it possible to read any git object into a buffer, by running `:Gedit SHA`. But it doesn't stop there. In a commit buffer, you can press `<Enter>` with your cursor on any other SHA code, and it will automatically open that object in a buffer. These buffers are as interactive as a webpage, but since we're in Vim, we never have to reach for the mouse.

Even though fugitive provides an excellent interface for browsing the git object database, you might still want to share a link to the object that you have open in Vim. The `Gbrowse` command will generate the github URL for whatever object is currently active in Vim. So fugitive gives you the best of both worlds: you can browse the repository mouselessly and offline from the comfort of your editor, and easily switch to a publicly accessible github URL when the need arises. Learn more in [part four][4].

### 5) [Exploring the history of a git repository][5]

The `Glog` command is a surprising one. The default `Glog` behaviour is quite different from the `git log` command that it wraps. Whereas `git log` shows a list of commit messages for the entire project, `Glog` loads all previous revisions of the current file into the quickfix list. This makes it extremely easy to review the history of a file. Learn more in [part five][5].

### Thanks to my sponsors

I'd like to say a big thanks to [HashRocket][hr] and [EngineYard][ey] for their sponsorship. I couldn't have completed this series without their support.

Finally, I'd like to thank Tim Pope for patiently answering my questions, reviewing drafts of each episode, and of course, for creating this awesome plugin in the first place. The Vim landscape would be a much more barren place without your plugins. Thanks Tim.

[extradite]: http://int3.github.com/vim-extradite/
[extradite-source]: https://github.com/int3/vim-extradite
[gitv]: http://www.gregsexton.org/portfolio/gitv/
[gitv-source]: https://github.com/gregsexton/gitv
[squeal]: http://twitter.com/MikeGrace/status/11389314823
[lookforward]: http://twitter.com/grahamsavage/status/66420233275064321
[github]: http://github.com
[hr]: http://hashrocket.com/people/work-at-hashrocket
[ey]: http://engineyard.com

[1]: /e/31
[2]: /e/32
[3]: /e/33
[4]: /e/34
[5]: /e/35
