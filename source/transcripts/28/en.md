I have written this document using the prime symbol to represent single quotes and apostrophes. Now I want to replace all of the single quotes with opening and closing curly double quotes. Rather than going through the document and making every change by hand, I'm going to take this opportunity to use the `:substitute` command.

Here's a pseudo-command that demonstrates what I want to do:

    :%sub/'(quoted text)'/“\1”/g

* match all single quoted strings
* capture the text within the quote in a register
* replace each match with the same text, surrounded with curly double quotes

To make this work, I'll have to create a search pattern that matches single quoted passages.

Rather than testing this live on the document, I'm going to open another buffer and paste in three examples of increasing complexity, which I'll use as test cases. I'll show you the iterative process that I use to refine a search pattern in Vim.

Iterations:

    \v'.+'
    \v'[^']+'
    \v'('\w|[^'])+'
    \v'(('\w|[^'])+)'

For my first attempt, I'll search for a single quote followed by any character one or more times, with a single quote at the end. The 'backslash-vee' at the start of my search enables *very magic mode*, which means that I don't have to escape common characters such as brackets and the plus sign.

This works fine for my first test case, but in the second test it hasn't distinguished between two separate quoted words.

To fix this, I'll change it so that, rather than matching any character, it only matches characters that are not single-quotes.

I can access my search history by pressing 'slash', followed by 'control-p', which stands for *previous*. I can then browse back and forward through historical searches by pressing ctrl-p and ctrl-n respectively. I can easily repeat any of these searches just by pressing the enter key, or I can use the cursor keys to move around the pattern, and edit it to suit my needs.

In this case, I only need to make a small modification, so I'll just do it inline in command-line mode. When I'm done, I hit enter, and my search pattern appears to be an improvement over the first attempt.

My third test case poses a problem: the quoted string contains an apostrophe. So I'll need to tweak the search pattern so that single quote characters immediately followed by a letter do not terminate the match.

Now, comparing my current pattern, with what I am aiming for, I can see at once that I need to make extensive changes. I don't like the idea of doing this in command line mode, so instead, I'm going to bring up the command-line *window* by pressing `q/` 'queue slash'.

This opens a new window at the bottom of the screen, which shows the last five or six search patterns. As you can see from the line numbering, Vim remembers the 50 most recent searches. I can move up and down using the `k` and `j` keys, and when I press enter, the command-line window is dismissed, and the selected search pattern is used for a new search.

The cool thing about the command-line window is that it's a regular Vim buffer. So all of the editing commands that you are used to are available to you. This makes it really easy to iterate on a search pattern. I can make the necessary changes to my previous attempt, then when I'm done, I just hit enter.

OK, now we are getting somewhere. The search pattern is matching the target string in each of my test cases. So I'm ready to build my substitution command.

The substitute command expects a search pattern, followed by a replacement string. But if you leave the search field blank, then Vim will automatically use the most recent search pattern. This is useful when you are still refining your search pattern, because it allows you to continue iterating without having to modify the substitution command.

Previously, I opened the command-line window with the `q/` command, and it showed the search pattern history. This time, I'm going to open the command-line window with the `q:` command. Instead of showing the history of search patterns, it shows the history of commands.

In this case, I'm starting from scratch rather than editing an existing command, so I'll just hit `i` to go into insert mode, where I enter my substitution command:

    %s//\1/

Lets see what happens... Ok, that's not worked. Undo. 

It looks as though I forgot to create a register to capture the quoted string. I'll bring up the command line search history window again, and wrap everything inside of my quotes in brackets. This text should be available in the replacement field of my substitute command through the `\1` 'backslash-one' capture.

Having updated my search pattern, I can repeat the substitution command by pressing 'colon' followed by `ctrl-p`.

That's looking more promising, but it's missing the vital ingredient: I forgot to wrap the replacement string in curly quotes. Once again, I'll bring up the command-line window with `q:`, then edit my most recent command.

Bang! Job done.

Opening the commandline window from commandline mode
----------------------------------------------------

I've demonstrated that you can open the commandline window either using 'queue-slash' or 'queue-colon'. But what if you started typing a command in the usual manner, then decided half way through that you need more editing power, and you'd rather switch to the commandline window?

In commandline mode, you can switch to the commandline window by pressing `ctrl-f`. The last line of the window will be populated with anything that you had entered before switching.

Recap
-----

Chances are, if you didn't know what the command-line window was good for, you've probably only ever opened it by accident. The 'queue-colon' command is precisely the inverse of Vim's quit command: 'colon-queue'.

Some people go so far as to put something in their vimrc file to prevent the command-line window from opening by accident. Hopefully, this demonstration will have convinced you that this is a vital feature, which makes working with Vim even more productive.

[arg]: https://github.com/peterbraden/dotfiles/blob/master/vimrc#L167-168
