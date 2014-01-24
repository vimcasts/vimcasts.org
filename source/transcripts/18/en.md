'Do one thing and do it well' is the principle of the Unix toolkit. Editing text is a broad domain, and there are many related tasks with which it overlaps. Vim acknowledges this by enabling certain tasks to be outsourced to external programs which do that one thing, and do it well.  This episode will demonstrate how the *par* program can be used for formatting text.

Introducing par
---------------

Par was written by Adam Costello in 1993, aiming to do one narrow task: reformat a single paragraph that might have a border on either side. The documentation is terse, and the author apologises for the implementation being unclean. Nevertheless, the program is stable, portable, and most important of all, extremely useful.



Outsourcing formatting with `formatprg`
---------------------------------------

The `formatprg` setting can be used to specify an external program which will be called by the `gq` command. To tell Vim to use par for formatting, set the formatprg option as follows:

    :set formatprg=par

Now, when I run `gqip`, the selected text is sent to par, then replaced with the program's output. Note that if I press `:` then the up cursor key, it shows the last command entered at the command line, which simply sets a range then passes it to the external program.

Better looking output
---------------------

Having set the `formatprg` option, the `gq` command calls par, but you can still use Vim's internal formatting engine by running the `gw` command instead.

Lets compare the output from Vim's internal formatter with that from par. Both of these examples have been hard wrapped with a line length of 72 characters, but they look different. Vim's internal formatter uses a 'greedy' algorithm, which maximises the length of each line, within the specified limit. The algorithm used by par is more sophisticated: it attempts to make consecutive lines as close in length as possible, while never exceeding the specified limit. The output from par is more aesthetically pleasing.

Excerpt from Leonardo's Kitchen notebook:

    On Saffron in Wine

    Saffron added to wine makes you very drunk
    and foul-smelling as well as making the wine
    taste most strange. As there is no receipt
    which instructs you to add saffron to wine I
    am surprised that my friend Gaudio Fullente
    so frequently offers it to one, but then as
    he is drunk and foul-smelling at all times it
    is possible I am wrong in my condemnation of
    his drink and it is he for whom I should have
    contempt.

    Excerpt from Leonardo's Kitchen Note Books.

Demonstrate `gw` with `:set tw=72`.
Demonstrate `gq` with `:set formatprg=par`.


Ability to align trailing comments
----------------------------------

Not only does par's output look better, the program is capable of handling passages that would confuse Vim's internal formatter. Here, for example, each line of text is is wrapped with open and closing comments. If I run this through Vim's internal formatting engine, it mangles the text, but Par handles this gracefully.

    |- Saffron added to wine makes you very     -|
    |- drunk and foul-smelling as well as       -|
    |- making the wine taste most strange. As   -|
    |- there is no receipt which instructs you  -|
    |- to add saffron to wine I am surprised    -|
    |- that my friend Gaudio Fullente so        -|
    |- frequently offers it to one, but then    -|
    |- as he is drunk and foul-smelling at all  -|
    |- times it is possible I am wrong in my    -|
    |- condemnation of his drink and it is he   -|
    |- for whom I should have contempt.         -|

Tweaking par's settings
-----------------------

If you run `par help` at the command line, you'll see a list of options that can be used to tweak the way the program behaves. You can specify these with the `formatprg` option as follows:

    :set formatprg=par\ -w40

This tells par to use a maximum width of 40 columns. It is necessary to escape the space with a backslash, just like at the command line when referencing files with spaces in their name.

I shall quickly demonstrate a handful of Par's options here.

### Repeat blank characters

This excerpt includes several blank lines. When I ask par to format it, the blank lines are left unchanged. If I pass the `r` flag to par, it will pad out these so called 'bodiless' lines with spaces.

### Justify text

When par is run with the `j` flag, the text is justified. Note that this requires extra spaces to be inserted between some words, but par distributes these quite evenly.

### Expel superfluous lines

When par is run with the `e` flag, it strips out superfluous lines.

### Quotation aware

The `q` flag tells par to handle passages with nested quotations in plain text emails. When I run par without the `q` flag, it breaks the nested quote. Now when I run it with the `q` flag, it handles the nested quote properly.


Conflict with Vim's `formatoptions`
-----------------------------------

If the `textwidth` option is set to a value greater than zero, you can make Vim automatically insert line breaks as you type. To do so, you must ensure that the `formatoptions` setting includes the `t` flag. With these settings enabled, Vim applies it's own internal formatting as you compose text. You can always apply the `gq` command afterwards, to tidy up the formatting with par.

Other programs
--------------

I've just grazed the surface of par. If you have any favourite settings you like to use with par, I'd be happy to hear about them in the comments. Also, if you know of any other external formatting programs besides par, I'd be happy to hear about their relative strengths and weaknesses.