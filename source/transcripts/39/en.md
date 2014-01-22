## Enable profiling on Vim startup

    :help profiling

Vim provides an Ex command for profiling scripts and functions written in Vimscript.

The basic strategy goes like this: we'll begin by calling `:profile start`, and providing a filename where we'd like the results to be written. Then we'll call `:profile file`, and provide the path of the Vimscript that we'd like to analyse.

The simplest way to setup profiling is to do it as Vim launches. Vim provides a couple of commandline flags that allow us run Ex commands at launch:

    $ vim -h | grep \<command\>
    --cmd <command>	Execute <command> before loading any vimrc file
    -c <command>		Execute <command> after loading the first file

The `--cmd` (sea-em-dee) flag allows us to run an Ex command before the vimrc file has even loaded, and the `-c` (dash-sea) flag allows us to run an Ex command after sourcing the vimrc and loading a buffer. Both of these are going to come in handy.

For starters, let's try profiling my `vimrc` file.

    vim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc'

We'll tell Vim to write the results to a file called `vimrc.profile`. With a second Ex command, we'll instruct Vim that we want it to profile the `vimrc` file. When we run this command, Vim launches up as usual. Now let's quit Vim, and we should see that there's a new file: `vimrc.profile`.

Let's have a look inside. This first block shows the time spent sourcing the script. In the next block, we get a breakdown for each function. At the end of the file, we get a summary of functions, sorted by execution time.

Well, there's nothing to see at the moment! These functions have been loaded into memory, but none have been executed. Let's try that again, but this time I'll tell Vim to execute the `Zzzz()` function after loading the first file:

    vim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc' -c 'call Zzzz()'

Remember, the `--cmd` commands are run before the vimrc loads, while the `-c` commands are run after the first buffer is loaded. Run that, [...wait a bit...]  quit Vim, and let's have another look at the profile data.

This time, the function summary shows that the `Zzzz()` method has been called once. The "Total" time is the time passed while the function was executing. The "Self" time is the "Total" time reduced by time spent in: other user defined functions, sourced scripts, and external shell commands.

If we take a look at the `Zzzz()` function in my vimrc, you'll see at once why it's taking so long to run!

## Real world example

If you were following along in the last episode, you might have spotted a flaw in the implementation of the markdown-folding script. This sample document should demonstrate:

    # Minimal C++ program

    Here is a minimal C++ program which prints "Hello world!":

    ```cpp
    #include <iostream>
    void main()
    {
      std::cout << "Hello world!";
    }
    ```

If a line begins with a hash symbol inside of a fenced code block, it should not create a new fold.

[Get the snapshot: g co c450f7f50cc73253c9f8186b7221bb1c4508772e]

Let me demonstrate my first attempt at solving this issue. If I open up the sample document, you should see that the folding expression now ignores lines inside of the fenced code block. You won't observe any problems with a small file such as this, but watch what happens if I open a longer markdown file:

    vim test/profiling/1.5_kilos.md

It takes a few seconds to load. And while we're waiting, note that Vim is maxing out one of my processors! That won't do at all.

Let's profile the folding script and see if we can locate the bottleneck.

Here, I've created a bash script that sets up profiling and launches Vim with the 1500 line markdown file. Note that it analyses the `markdown/folding.vim` script, and saves the results to a file at the path specified here.

    vim --cmd 'profile start MarkdownFolding-file.result' \
        --cmd 'profile! file *markdown/folding.vim' \
        -c 'profdel file *markdown/folding.vim' \
        1.5_kilos.md

I'll save that file, and make it executable.

    chmod +x MarkdownFolding-file.runner

Now we can profile the script just by running (dot-slash and the name of the script):

    ./MarkdownFolding-file.runner

That launches Vim with profiling enabled. As before, we're seeing a delay of several seconds before the buffer opens. Now we'll quit Vim, and open up the results file:

    vim MarkdownFolding-file.result

If we skip to the summary at the end, it's immediately obvious where the bottleneck is: this function called `IsFenced()` is taking about 5 seconds to run.

Let's find the detailed breakdown of the `IsFenced()` function. We get the total number of calls, and the time spent executing this function. But we also get a breakdown of the time spent executing each line within the function.  Clearly, this call to the `searchpairpos` function is quite expensive. It doesn't help that it's being called over 1500 times!

## 2nd attempt

If we look at the code, there's a really simple optimization that we can make. This `HeadingDepth()` function is called once for every line in the file. At the moment, it checks every single line to see if it's part of a fenced code block. But we only actually care about that if the line in question looks like a markdown heading.

Let's move the `IsFenced()` test down here, so that it only runs if the current line starts with a hash symbol. We'll save that change, then run the profiling script again:

    ./MarkdownFolding-file.runner

Straight away, it's clear that things are running faster. We'll quit Vim, then open up the results file. Recall that the previous benchmark took about 5 seconds. This small change has cut it down to just over a second. That's a big improvement, but it's still not good enough.

## 3rd attempt

The `searchpairpos()` function works by looking forward and backward from the current cursor position for an opening pattern and a closing pattern. It does the job, but as we've seen, it's expensive to run.

My next idea was to simply look at the syntax highlighting for the current line, and check if it used the syntax group `markdownCode`. I can quickly demonstrate by running this expression:

    :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

If I place my cursor on a header and run this, it outputs `markdownH1`. If I place my cursor on a codeblock and run the same command, it outputs `markdownCode`. Let's throw out this expensive algorithm, and replace it with a simple syntax check.

Save the change, then run the profiling script again:

    ./MarkdownFolding-file.runner

Bang! That was quick!

Let's have a look at the results. Now the `IsFenced()` function is completing in about 100 milliseconds. That's down from about 1 second when we used the `searchpairpos()` function. So we've made another massive gain. I'm happy to call that good enough for now.

## Outro

Thanks to Sergey Alexandrov for raising this issue on github. I learned a lot by working through it, and I hope this demonstration will inspire other plugin authors to work through any performance issues.
