### Meet the star command

In Normal mode, the star command performs a search for the word under the cursor. With my cursor on the word 'coffee', the star command makes my cursor jump to the next occurrence of that word:

    A proper cup of coffee from a proper copper coffee pot.

The same thing happens in Visual mode. I'll select a few words, and leave my cursor on the word 'coffee'. Once again, the star command searches for the word under the cursor, which has the effect of extending the range of the visual selection.

I'm not a big fan of this behavior. I'd prefer it if Vim searched for the current selection, rather than the current word. Take this short excerpt, for example:

    Visual star: [http://vimcasts.org/search?q=visual-star][q]

    [q]: http://vimcasts.org/search?q=visual-star

I'd like to be able to select the URL, then quickly perform a search for it. Having made the selection, my cursor is now positioned on the word 'star'. And sure enough, when I press star key it searches forwards for the next occurrence of the word 'star'.

Vim's documentation actually provides a suggestion on how to create a mapping that would search for the selected text.

    :help visual-search

It works by yanking the selected text, then dialing up the search prompt and pasting the text into the search field.

Let's apply that mapping and try it out:

	:vmap X y/<C-R>"<CR>

I'll select the text `vimcasts.org`, then press the `X` key to trigger this mapping. On the surface, it looks like it's worked, but watch this: I can change the dot symbol to any other character and the pattern will still match. That's because, in a regular expression, the dot symbol stands for any character. If we wanted to match a dot character literally, we would have to escape it in the pattern.

The dot character is just the start of the problems with this mapping. If I select the entire URL and trigger the same mapping, it fails in a more obvious fashion. This time, the problem is caused by the forward slash character, which terminates the search field.

Take another look at Vim's documentation, and you'll see that this mapping comes with the warning: 

> Note that special characters (like `.` and `*`) will cause problems.

This mapping is too simplistic, but these problems can be avoided. I recommend installing the visual-star-search plugin, which creates a smarter mapping that  automatically escapes special characters.

I'll just load the visual-star script:

[source the `visual-star.vim` file]

That creates a new visual mode mapping for the `*` key, over-riding the default behaviour. Now, I can visually select the entire URL, hit the star key, and boom! It searches for the selected text.

If we inspect the pattern, you'll see that it has escaped all of the forward slash characters for us. One other important detail: the pattern begins with the very no-magic switch, which turns off the special meaning of characters such as dot and star, so that they don't need to be escaped. If you want more details about how this command works, refer to Practical Vim, tip 78 - Escape Problem Characters.

The pattern generated by the visual-star command can be re-used with any of Vim's commands that work with patterns, including the `:substitute`, `:global`, and `:vimgrep` commands. For example, I can search all files in the current directory for this URL by running:

    :vimgrep /<C-r>//g *

I find the visual star mapping to be indispensible. I recommend installing it and making it part of your workflow.