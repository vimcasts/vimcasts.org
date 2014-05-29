---
:title: Using Python interpolation in UltiSnips snippets
:date: 2014/05/29
:poster: /images/posters/ultisnips-python.png
:duration: 296
:number: 67
:tags: Insert mode, plugins
---

[UltiSnips][] can execute Python code and interpolate the result into a snippet. This makes it possible to create snippets that react to the text entered in each field. We'll look at an example that performs a simple calculation and inserts the result into our document.

READMORE

### The basics of Python interpolation in UltiSnips

Python scripts can be embedded inside UltiSnips snippets using `` `!p` ``. In this context, UltiSnips predefines a few Python objects and variables for us. For example, the `snip.rv` variable stands for *return value*. It represents the text that will be interpolated into the document when our snippet is expanded. The `t` variable is a list representing the values of tabstops numbered one, two, three, and so on. For more details, look up `:help UltiSnips-python`.

### A snippet to calculate average typing speed

The snippet that I demonstrated in the video appeared in `text.snippets` like this:

    global !p
    def fraction(a, b):
        try:
            return "%.1f" % (float(a)/float(b))
        except (ValueError, ZeroDivisionError):
            return "ERR"
    endglobal

    snippet 75wrds "Log a 750words.com session" b
    750words.com: ${1:750} words in ${2:20} minutes - `!p
    snip.rv = fraction(t[1], t[2])
    ` wpm.
    endsnippet

The `global` block allows us to create Python functions, which we can then call from any snippet in the same snippet file. This `fraction()` function attempts to cast two arguments to floats and divide one by the other, rounding the result to a single decimal place. If it encounters an exception, it returns the string "ERR".

When using this snippet, the words-per-minute calculation is updated in real-time as the values for tabstops one and two are changed. It's almost like working with a spreadsheet!

### Sharing helper functions between snippet files

The `fraction()` function defined above would be available only to snippets defined in the `text.snippets` file. We could make that function available to other snippet files by moving it into a `~/.vim/pythonx/snippet_helpers.py` file:

```python
def fraction(a, b):
    try:
        return "%.1f" % (float(a)/float(b))
    except (ValueError, ZeroDivisionError):
        return "ERR"
```

We could then import this into a snippet file by including this:

    global p!
    from snippet_helpers.py import *
    endglobal

One potential gotcha to watch out for here is that Vim will load the `snippet_helpers.py` one time only. That means that any changes you make to the helper functions in `snippet_helpers.py` won't be seen by your snippet files until you reboot Vim. Despite that limitation, this mechanism is still useful for sharing helper functions between your snippet files.

### Further reading

* [UltiSnips][]
* `:h UltiSnips-interpolation`
* `:h UltiSnips-python`
* `:h UltiSnips-globals`

I'd like to thank Holger Rapp for his great feedback on early drafts of this screencast.

[UltiSnips]: https://github.com/SirVer/ultisnips

