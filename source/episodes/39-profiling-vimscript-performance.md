--- 
:title: Profiling Vimscript performance
:date: 2012/12/03
:poster: /images/posters/profiling.png
:flattr_id: "1045993"
:duration: 489
:number: 39
:tags: vimscript, performance
---

Vim users are unforgiving of plugins that impair performance. Luckily, Vim provides built-in profiling tools that make it easy to diagnose performance issues. We'll start by looking at how to profile the vimrc file, then move on to a real world scenario where profiling helped to identify and aleviate a performance bottleneck.

READMORE


In the video, I demonstrate how profiling enabled me to locate a bottleneck in my `markdown-folding` script. I used a 1500 line markdown file as a test case. The first attempt at a solution took 5 seconds to execute, the second solution ran in about 1 second, and the final solution took just 100 miliseconds. You can follow the same process by [reading the discussion on github][issue].

**NOTE:** Vim's profiling feature is not enabled in all builds. You can check by running [`:version`](http://vimdoc.sourceforge.net/htmldoc/various.html#:version), and looking for the 'profile' feature. A plus sign prefix indicates that it is enabled.

## Enable profiling on Vim startup

The `--cmd` and `-c` flags can be used to run Ex commands on Vim startup:

<table>
    <tr>
        <th>flag</th>
        <th>effect</th>
    </tr>
    <tr>
        <td><code>--cmd <command></code></td>
        <td>Execute <command> before loading any vimrc file</td>
    </tr>
    <tr>
        <td><code>-c <command></code></td>
        <td>Execute <command> after loading the first file</td>
    </tr>
</table>

You could profile the load time for your `vimrc` file as follows:

    vim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc'

To profile a function in the `vimrc` file, you would have to call it. For example, if there was a function called `Zzzz()`, you could profile that function by running: 

    vim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc' -c 'call Zzzz()'

Remember: the Ex commands specified with `--cmd` are run *before* loading the `vimrc` file, while Ex commands specified with `-c` are run *after* loading the first buffer.

## Writing a simple script to profile Vim

In the example in the video, we could have profiled the Vimscript by launching Vim from the command line like this:

    vim --cmd 'profile start MarkdownFolding-file.result' --cmd 'profile! file *markdown/folding.vim' -c 'profdel file *markdown/folding.vim' 1.5_kilos.md

We can make life a bit easier by wrapping this in a bash script:
    
    #!/bin/bash
    set -e
    vim --cmd 'profile start MarkdownFolding-file.result' \
        --cmd 'profile! file *markdown/folding.vim' \
        -c 'profdel file *markdown/folding.vim' \
        1.5_kilos.md

Save this in a file called `MarkdownFolding-file.runner`, then it can be executed just by calling:

    chmod +x MarkdownFolding-file.runner
    ./MarkdownFolding-file.runner

This analyzes the `markdown/folding.vim` script, and saves the results to a file called `MarkdownFolding-file.result`.

Note the `!` symbol in the line `profile! file *markdown/folding.vim`. Without the bang, Vim would only profile the loading of the script. The bang instructs Vim to also profile the execution of its functions. See [`:help profiling`][h] for more details.

In theory it should be safe to include the argument `-c 'quit'` in the profiling script, which would tell Vim to quit after loading the first buffer. In my case, I found that Vim would quit before executing the code that I wanted to profile. If anyone can suggest a way around this, I'd be interested to know more.

## Further reading

* [`:help profiling`][h]
* [Improving Vim's startup time][usevim]
* [Profiling vim startup time question on StackOverflow][so]
* [Github discussion around the markdown-folding issue][issue]

[usevim]: http://usevim.com/2012/04/18/startuptime/
[issue]: https://github.com/nelstrom/vim-markdown-folding/issues/1
[so]: http://stackoverflow.com/a/8347244/128850
[h]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#profiling
