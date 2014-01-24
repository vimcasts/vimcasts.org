Intro
=====

Even if a macro is composed of only a few keystrokes, it can save you a lot of
effort if you replay it enough times. Occasionally you will be faced with an
editing task which can be accomplishd by recording a more intricate macro, and
in this case it may save you even more time. In this episode, I'm going to
demonstrate a complex macro that I recently used in the real world.

MarkDown documents are usually converted to HTML by filtering them through a
script. But sometimes the target format is not so simple, and a bit of manual
editing is required.

This MarkDown document is fairly well-structured. There are 21 paragraphs,
each preceded by a numbered heading. The paragraphs are all roughly the same
length, but some are a little shorter, and others are a little longer. 

The target format is a structured HTML document. Each paragraph from the
Markdown document corresponds to a 'slide' in the target document. It begins
with a navigational list, containing links to each of the 'slides' below.

The fact that the input and output formats are so well structured makes it
easy to automate the conversion with a carefully constructed macro.

Preliminary notes
-----------------

I shall be making use of the surround plugin. Although this editing task could
be accomplished without it, this plugin considerably speeds up certain
operations, as you shall observe. It is outwith the scope of this video to
give detailed usage and installation instructions, but links shall be provided
in the shownotes.

Walkthrough
-----------

I've created a skeleton template for the document. This contains all of the
necessary structural markup. I'll begin by copying the entire Markdown
document in to the main content section. I can read the contents of a file in
place with the `:r` command:

    :r pecha-kucha-script.md

Which inserts the entire specified file at the current cursor position.

### Start recording the macro ###

To begin recording the macro, I press the 'q' key followed by 'a', which is
the register I want to save it to. You know you've done it right if it says
'recording' at the bottom of the screen. Now, every key that I press is
captured, until I press 'q' in normal mode, which stops recording the macro.

### Jump to slide header ###

When recording a macro, it is best to move around the file using commands that
can acheive a similar effect when replayed in a different context. I need to
move my cursor to the first slide heading. I could use `13G` to jump to line
'13', but this wouldn't translate well when the macro was replayed later.
Instead, I'm going to search for the pattern of a hash at the beginning of the
line, followed by a two digit number.

I hit the forward slash key to activate search, then enter the pattern:

    "caret hash backslash-D backslash-D"
    ^#\d\d

As soon as I hit enter, my cursor jumps to the first occurance of this
pattern, which is just where I want it. 

### Capture the slide number ###

I want to keep hold of the number for the current slide, so I'm going to save
it in a register. First, I move the cursor one place to the right by pressing
the `l` key. Now the `de` command will delete the number, but I want to make
sure I can access it later, so I prepend 'double-quote-z' `"z`. This places
the deleted text into the 'z' register. You can use any lowercase letter as a
register. 

### Capture the heading ###

All of the headings use the same format: a hash followed by a two digit number
and a space, then a dash followed by another space, and then the text of the
heading. 

I want to save the actual text of the heading, so I move my cursor forwards by
pressing the `w` key twice. I can discard everything on the line before this,
so I issue the command:

    d0

In this case, I don't want to reuse the text, so I won't bother prepending a
register.

I do want to save everything else on this line, so I specify register 'x' and
delete the entire line:

    "xdd

After the heading there is a blank line. I delete this with the `dd` command.
Again, I know that I won't need to reuse this, so I don't specify a register.

### Wrap the paragraph in a <li> element with id="slide-01" ###

Most paragraphs are 4 lines long, but some are shorter and others are longer,
so if I was to move the cursor down 4 times it wouldn't always work the way I
want it to. However, I can visually select the current paragraph, no matter
how long it is, by issuing the command:

    "shift-v IP"
    Vip

I want to wrap this election with a list-item element. I can do so by
invoking a command from the surround plugin:

    s<li>

There is a kind of grammar to the surround plugin, which makes it quite easy
to learn. When you are in visual mode, the 's' key says "surround the
selection with the next element". If you follow that with an opening angle
bracket, surround understands that you are entering an XML style tag, and
opens a prompt where you can enter the name of the element. When you enter the
closing angle bracket, the selection is wrapped with opening and closing tags.

Note that, because the selection was made using visual *line* mode, the
opening and closing tags are each given a line of their own.

I want to add an id to the list-item element that I just created. My cursor is
currently on the opening angle bracket, so if I press the `%` key, I can jump
to the closing angle bracket. Then I press `i` to go into insert mode, and I
type the id attribute, leaving a gap where the number should go.

     id="slide-"

When I leave insert mode, my cursor is placed on the closing quote mark. I
want to paste the number that I captured earlier in front of the current
cursor position, so for this I use `P` "shift-P". Remember that I saved the
number into register 'z', so to paste this I run the command:

    "double-quote z shift-p"
    "zP

Creating the navigation
-----------------------

Now I want to create an entry in the navigation list that links to this slide.
Once again, the best way for me to move my cursor is to search for something
that marks the navigation menu. Instead of using the forward slash, I can
search backwards by pressing the question-mark key. I'm going to use the
pattern:

    \/ol

When I press enter, my cursor jumps to the end of the navigation list. The
reason why I move to the end, rather than the beginning of the list, is so
that I can append the title at the end of the list. The title of the slide was
saved in register 'x', so if I run:

    "double-quote x shift-P"
    "xP

it places the title on the line above my cursor. To fix the indentation, I run
the command `==` "equals-equals".

With my cursor on the first character of the title, I hit:
    
    "v dollar h"
    v$h

To go into visual mode, selecting to the end of the line, then back one
character to make sure that the line-break itself is not included in the
selection. Once again, I use the surround plugin:

    s<li>

which wraps the selection with a list item element. Note that this time, the
opening and closing tags are on the same line as the selected text. This is
because I made my selection using visual character mode (with a small 'v'),
whereas the previous time I used visual line mode (triggered with a large
'V').

Next, I want to wrap the inner text with a link. I can select the inner
contents of a tag using the text-object:

    vit

Then I surround the selection with a link tag:

    s<a>

I want to add an "href" attribute, so I press `%` to move to the closing angle
bracket, then enter insert mode by pressing `i`. I then type the href
attribute, leaving a gap for the number I captured earlier.

    href="#slide-"

When I hit escape, my cursor is positioned on the closing quote, so I can
paste the number from the 'z' register by typing:

    "double-quote z shift-p"
    "zP

Now I have an entry in the navigation which links to the corresponding slide,
so I can finish recording the macro by pressing `q`.

Replay the macro
----------------

The macro can be replayed by pressing the "at" key followed by the register in
which it was saved. In this case, I saved it to the 'a' register, so it can be
replayed by pressing "at-A":

    @a

That has created a navigational link to the second slide, and wrapped up the
corresponding content in it's own list element.

I can also prepend a count before replaying a macro, and it will be executed
the specified number of times. I know that I have 20 slides, and two have
already been processed, so I can finish off the job by running:

    18@a

Bang! Job done.

