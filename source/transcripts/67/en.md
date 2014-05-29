Lately I've been using 750words.com to track my daily progress as I learn a new keyboard layout.
The site tells me how many words I typed and how long I took.
I log those values in a plaintext file, along with my average typing speed for that day:

    750words.com: 320 words in 23 minutes - 13 wpm

I've created a simple snippet that enters some of the boiler plate for me:

    snippet 75wrds "Log a 750words.com session" b
    750words.com: ${1:750} words in ${2:20} minutes - ${3:(wordcount/duration)}wpm
    endsnippet

This rudimentary snippet has a placeholder for the words per minute value, but I have to run the calculation by hand. We could enhance this snippet by using UltiSnips Python interpolation functionality.

Let's modify our snippet to make it calculate the typing speed for us.

    snippet 75wrds "Log a 750words.com session" b
    750words.com: ${1:750} words in ${2:20} minutes - ${3:(wordcount/duration)}wpm
    endsnippet

We'll leave tabstops one and two as they are, but we'll replace the third tabstop with a python interpolation block, which is contained with backticks and begins with "bang-pee". I'm going to break this snippet across a couple of lines to make it easier to read.

UltiSnips sets up a few Python objects and variables for us in this context. For example, the `snip.rv` variable stands for *return value*. It represents the text that will be interpolated into the document when our snippet is expanded. The `t` variable is a list, representing the values of tabstops numbered one, two, three, and so on.

We could calculate the average typing speed by dividing the wordcount (from tabstop one) by the duration (from tabstop two). We then assign the return value from that calculation to `snip.rv`:

    snippet 75wrds "Log a 750words.com session" b
    750words.com: ${1:750} words in ${2:20} minutes - `!p snip.rv = float(t[1])/float(t[2])` wpm
    endsnippet

Let's try that out. I'll type the trigger word then expand it, and look at that: the average word speed has been calculated for us. The value updates instantly as I overwrite the default text for each tabstop. I can switch to Normal mode, and when I adjust either of the first two values, the calculation updates in real-time. It's almost like working with a spreadsheet!

    750words.com: 750 words in 20 minutes - 37.5 wpm

Well that's pretty neat, but if I change either of these tabstops to contain anything other than a number, then our snippet blows up. Python raised an exception and UltiSnips printed the stack trace into a scratch buffer. So let's adjust our Python code to make it handle this exception more gracefully.

UltiSnips allows us to create Python functions by placing them inside of a `global` block. Here, we'll define a `fraction` function, which attempts to cast two arguments to floats and divide one by the other, rounding the result to a single decimal place. If it encounters an exception, it returns the string "ERR".

    global !p
    def fraction(a, b):
    	try:
    		return "%.1f" % (float(a)/float(b))
    	except (ValueError, ZeroDivisionError):
    		return "ERR"
    endglobal

We can call this function from our Python interpolation block:

    snippet 75wrds "Log a 750words.com session" b
    750words.com: ${1:750} words in ${2:20} minutes - `!p snip.rv = fraction(t[1], t[2])` wpm.
    endsnippet

Let's try it out. Once again, the average typing speed is updated in real time as the first two tabstops change. Note too that this time the result is rounded to one decimal place, which looks a lot neater. This time nothing bad happens if I accidentally enter a non-numerical value.

## Vim 7.4 - use `snippet_helpers.py`

At present, this `fraction()` helper function is only available to snippets defined in this `text.snippets` file.
Let's set up a general snippet helpers file, in the "dot-vim slash python-Ex" directory:

    :!mkdir -p ~/.vim/pythonx
    :e ~/.vim/pythonx/snippet_helpers.py

We'll paste the `fraction()` helper into the new file. Back in our snippets file, we can import the helper functions, making them available to the snippets defined here. This mechanism makes it easy to share helper functions between different snippet files.
