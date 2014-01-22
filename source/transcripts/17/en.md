It is sometimes preferrable to format text with hard wrapped lines, for example when writing emails in plaintext. Vim can apply this style of formatting for you. This episode shows some of the options which allow you to customize Vim's text formatting.

Format current paragraph
========================

The `gq` command applies formatting to a section of text. You can apply this to the current paragraph with the `ip` motion. So the command:

    gqip

will reformat the current paragraph.

Notice that this moves the cursor to the last line of the paragraph. Alternatively, if you replace `gq` with the `gw` command, it restores the cursor position to the word it was on before the paragraph was reformatted.

Controlling the line width
--------------------------

There are two settings that can be used to control the length of a line in Vim. These are:

    textwidth
    wrapmargin

Textwidth can be set to a number representing the maximum allowed width of a line. When set to zero, which is the default, Vim will use the full width of the window up to a maximum of 80 characters. 

    :set nonumber
    :set columns=40
    gq

Here, I have textwidth set to 0, and I've reduced the window width to 40 columns. When I reformat the paragraph, it uses the full width of the window.

    :set columns=100

Now, if I set the window width to 100 and reformat the paragraph, Vim does not allow the line width to exceed 80 columns.

The wrapmargin setting can be used to specify the number of characters from the right window border where wrapping begins.

Here, if I set wrapmargin to 5, it instructs Vim to use the entire width of the window minus 5 characters.

    :set wrapmargin=5

If you have line numbers switched on, they use up some of the page width, so the wrapmargin setting can be used to compensate for that.

When textwidth is set to anything greater than zero, the wrapmargin setting has no effect. Instead, lines will be formatted using the number of characters specified by textwidth, regardless of the width of the window.

    :set textwidth=40

Here, for example, I have set textwidth to 40. When I reformat the paragraph, none of the resulting lines should exceed 40 characters.

Formatting options
==================

The way that Vim formats text can be influenced with the `formatoptions` setting. The `:help` entry on `fo-table` gives details of each of the available flags. I'm going to demonstrate what a couple of these do. In each of the following, I have textwidth set to 40.

To begin with, I'm going to set formatoptions to a blank string:

    :set fo=

As I enter text, it is appended to the current line, regardless of the length. If I exceed 40 characters, it just keeps on going. I can reformat the paragraph when I leave insert mode, by running the `gq` command.

Next, I'm going to add the `t` flag to formatoptions:

    :set fo+=t

Now, when I type text and the current line exceeds the maximum allowed line length, Vim automatically inserts a line break. 

This automatic text wrapping is fine while composing, but it lacks when editing text. For example, if I type text at the begining of a line, it can cause the line to exceed the maximum line length. Or if I delete text, it can cause the current line to appear too short. 

If this situation arises, it can be swiftly rectified by running the `gq` command.

Next, I'm going to add the `a` flag to formatoptions:

    :set fo+=a

This causes Vim to reformat the paragraph every time a line is changed. Now the paragraph is reformatted when I insert text at the beginning of a line, and also when I delete text.

External program
================

The `formatoptions` setting is used with Vim's internal formatting algorithm. Vim supports two methods for setting an alternative formatting engine to use. I won't cover either of these in this episode, but note that the `gq` command will only invoke Vim's internal formatter if both the `formatexpr` and `formatprg` options are blank. On the other hand, the `gw` command will always invoke Vim's internal formatting engine, even if one of the alternate formatters is enabled.