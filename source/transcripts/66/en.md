UltiSnips was written by Holger Rapp. You can find the plugin and installation instructions on github. I've already installed it, so let's get started.

I write the shownotes for Vimcasts episodes in markdown format, starting with a block of yaml frontmatter to define some metadata about the episode. There's a certain amount of boilerplate involved here, so let's create a snippet to speed up its creation.

UltiSnips provides the `UltiSnipsEdit` command, which opens a file containing snippets for the current filetype, in this case markdown. As you'll see, I've already defined a basic snippet for yaml frontmatter:

    snippet fmatter
    ---
    title: $1
    date: $2
    tags: $3
    ---
    $0
    endsnippet

The `snippet` and `endsnippet` keywords delimit the definition. The text immediately after the word `snippet` is the trigger word. When we type this word and activate UltiSnips, it will insert each of the lines inside of the definition.

The dollar symbol has a special meaning here. It defines a tabstop, which is a location that we can jump to when the snippet is activated. This snippet has tabstops numbered sequentially, 1, 2, 3, followed by the special dollar-zero tabstop. This defines the final position of the cursor, regardless of how many tabstops you specify.

Let's try out this snippet. I'll open a fresh markdown document for this episode's shownotes. To insert our snippet, I'll type the trigger word then hit the tab key. Boom! UltiSnips expands the snippet. My cursor is positioned at tabstop number 1. Pressing `ctrl-j` jumps to the next tabstop, while pressing `ctrl-k` jumps to the previous tabstop. I can fill out each field, then advance to the next one by pressing `ctrl-j`.

### Specifying default text

This snippet provides bare functionality, but let's change it to include some default text. UltiSnips lets us specify placeholders for each tabstop like this:

    title: ${1:Meet UltiSnips}

We could use today's date to populate the second field, by using backticks to run the `date` command in the shell. UltiSnips will interpolate the result into our placeholder field:

    date: ${2:`date +%Y-%m-%d`}

I'll save the file and switch back to the markdown document. UltiSnips reloads snippets for us automatically, so our revised snippet should be available already.

When I activate the snippet this time, it pre-fills the date field with today's date, and the title field with the specified default text.

If I wanted to keep the default text, I could advance to the next tabstop with `ctrl-j`.
I want to customize the title, so I'll move back to the first tabstop by pressing `ctlr-k`.
Note that the placeholder text is selected and Vim indicates that it is in `Select mode`.
(This is one of the few uses that I've come across for select mode.)
That means that when I type any printable character, Vim deletes the selction, switches to Insert mode and enters the specified character.

### Duplicate a field with mirroring

Now that I've set up the metadata for this article, I'm ready to write the body. I want to start with the title, which I'll duplicate from the metadata, using a single hash sign to indicate that it's an h1 header. Rather than doing this by hand, we can use UltiSnips mirroring feature to populate both fields with the same text.

    snippet fmatter
    ---
    title: ${1:Meet UltiSnips}
    date: ${2:`date +%Y-%m-%d`}
    tags: $3
    ---
    # $1
    $0
    endsnippet

The second instance of the dollar-one tabstop will mirror the contents of the first tabstop. We'll prefix that with a hash sign, to indicate that this is an h1 header.

Let's try that out. As I enter the title in the yaml field, it appears simultaneously as a header at the top of the document. This mirroring continues to work if I switch to Normal mode and edit the title.

The mirroring is disabled when I edit outside of the snippet.

We've run through the basics of UltiSnips: tabstops, placeholders, shell interpolation, and mirroring. We'll look at some of the more advanced features in later episodes.
