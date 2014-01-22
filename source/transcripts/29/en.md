There are a couple of plugins for Vim that make it easy to align text. There is the [Align.vim][a] plugin by Charles Campbell, and then there is [Tabular.vim][t] by Matt Wozniski. They differ slightly in their patterns of use, but both achieve a similar result. In this episode, I will demonstrate how to use Tabular.vim.

Aligning assignments
====================

Here's a fairly typical example where I have assignments on multiple lines. I want to line them up so that the equals sign is positioned in the same column on each line.

The Tabular plugin provides a command called `Tabularize`, which accepts a regular expression as an argument. If I begin by enabling visual line mode and selecting a range, then when I press the colon key and call `Tabularize` it will act only on the selected lines. In this case, the pattern that I want to align is simply an equals sign, so I pass the argument `/=` 'slash equals'.

    one = 1
    two = 2
    three = 3
    four = 4

And when I hit enter, the range is modified so that the equals signs all line up vertically.

### Range detection ###

In this example, I manually highlighted the lines that I wanted to act upon, but the tabularize command is actually pretty smart about ranges. If I undo that last edit, then run the tabularize command again, but this time without specifying a range, it actually achieves the same result. When activated from normal mode, the command searches up and down from the current line, automatically creating a range from all of the lines that match the specified pattern.

There are times when the automatic range detection can be fooled.

    var video = {
        metadata: {
            title: "Aligning assignments"
            h264Src: "/media/alignment.mov",
            oggSrc: "/media/alignment.ogv"
            posterSrc: "/media/alignment.png"
            duration: 320,
        }
    }

In this javascript example, I want to align the colon characters. Watch what happens if when I invoke `Tabularize` without specifying a range:

    :Tab/:

This is not the effect that I was looking for. I only want the colons to line up inside of the metadata object, leaving this line untouched. I'll just undo that change, and this time I'll make a visual selection to explicitly specify the range. Note that the selection can be made rapidly using the `vi}` text object. And this time, when I run:

    :'[,']Tab/:

it achieves the desired effect.

The `\zs` atom
==============

Here, I've aligned the colon characters in a column, just as I did previously using the equals sign. This is valid JavaScript, but there is another way that we could have aligned the properties, which some people might prefer. This style keeps the colon next to the identifier and uses spaces to pad the assigned values so that they all line up.

We can create this effect by modifing the regular expression to use the `\zs` 'backslash-z-s' atom. This is particular to Vim's regular expression engine, but if you are familiar with the positive-lookbehind assertion, then you might recognise the effect it has. In practice, it means that the first character after the colon is used as the alignment delimiter. In this case, the first character after the colon is a space. 

    :Tab/:\zs

By passing this pattern to the `:Tabularize` command, the assignements are aligned while leaving the colons together with the identifiers.

Aligning multiple tokens
========================

Lets take a slightly more complex example now.

    Scenario Outline: eating
      Given there are <start> cucumbers
      When I eat <eat> cucumbers
      Then I should have <left> cucumbers

      Examples:
        |start|eat|left|
        |12|5|7|
        |20|5|15|


This is a scenario outline for cucumber steps. I would like to pad each cell of the table with whitespace to match the widest item in the same column. Even though this example requires alignment of multiple tokens per line, the interface for the Tabularize command is just the same as before. I only need to change the pattern to use a pipe symbol:

    :Tab/|

If you find yourself using a particular pattern with the `:Tabular` command often, you might want to save yourself a few keystrokes by creating normal and visual mode mappings. 

    if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
    endif

Or you could take it a step further, by creating an insert mode mapping which triggers the `:Tabular` command when you type the character that you want to align. Tim Pope shows us how in this [gist][], which calls tabularize each time a pipe character is inserted. If I copy this into my .vimrc file and reload it, then you'll see that my cucumber table is automatically realigned as I create it. Pretty neat!

[a]: http://www.vim.org/scripts/script.php?script_id=294
[t]: https://github.com/godlygeek/tabular
[gist]: https://gist.github.com/287147
