## :Subvert - a supercharged substitution DSL

You're already familiar with the `:substitute` command:

    :[range]substitute/target/replacement/[flags]

The `:Subvert` command can take a similar format:

    :[range]Subvert/target/replacement/[flags]

In both cases, the command name can be shortened to the initial letter, which makes them look identical apart from the case of the letter 's'.

`:Subvert` behaves a lot like Vim's standard `:substitute` command: it accepts the same flags and operates the same way over a range, but the target and replacement fields are handled differently.

To illustrate this, lets look at the case of changing a word in both singular and plural forms.

### Working with irregular singular/plurals

Here we have 3 models with associations between them: a user has many pumpkins and mice. 

    def User < ActiveRecord::Base
      has_many :pumpkins
      has_many :mice
    end

    def Pumpkin < ActiveRecord::Base
      belongs_to :user
    end

    def Mouse < ActiveRecord::Base
      belongs_to :user
    end

Suppose that we we wanted to change pumpkins into potatoes. Let's use the `:Subvert` command to do it.

We'll target the word `pumpkin` and replace it with `potato`. We'll use the `g` and `c` flags, which behave just the same way as they would with a regular substitute command.

    :%Subvert/pumpkin/potato/gc

Before I hit enter, note that I've supplied the target and replacement strings in lowercase. And yet, when I execute the command, it picks up the occurrence of `Pumpkin` that begins with an uppercase letter. I'll press `y` to confirm that change, and again to change the second occurrence.

The plural form of `potato` is irregular: it ends with `-es`. So we've got a bit of tidying up to do here.

Instead of fixing it by hand, let's undo the change, then refine our `Subvert` command. We can use curly braces to specify a set of alternative endings for our target and replacement words. The plural form of pumpkin simply adds the letter `s`, whereas potato ends with `es`:

    :%Subvert/pumpkin{,s}/potato{,es}/gc

That command correctly handles both the singular and plural forms.

Let's look at another example: this time, we'll convert the word `mouse` to `trackpad`. Once again, we're dealing with an irregular plural: mouse becomes mice (not mouses).

We start off by specifying the part of the word that is common to both forms, which in this case is just the letter 'm'. Then in braces, we specify each alternative ending for the target and replacement:

    %S/m{ouse,ice}/trackpad{,s}/gc

The result: mouse changes to trackpad, and mice becomes trackpads. That's pretty handy!

### Working with MixedCase and snake_case

The subvert command is also useful if you need to refactor a name that appears in both `MixedCase` and `snake_case`. For example, in ruby, module names and class names are given in `MixedCase`, while `snake_case` is used for naming the corresponding files. 

    require "parslet"
    require "vimprint/parser/insert_mode"
    require "vimprint/parser/visual_mode"
    require "vimprint/parser/cmdline_mode"
    module VimPrint
      class Parser < Parslet::Parser
        include InsertMode
        include VisualMode
        include CmdlineMode
      ...
      end
    end

Suppose that we wanted to change `insert_mode` to `replace_mode`. We could do it using the `:Subvert` command:

    :%S/insert_mode/replace_mode/gc

Even though I've only specified the snake case format, the Subvert command automatically applies the change to the MixedCase versions as well.

### Swapping words

You can also use the `:Subvert` command to swap all occurrences of two words. Here's a slightly daft example: we'll use the `:Subvert` command to swap all occurrences of `vim` and `tmux` in this sentence:

    Anyways I made a vim plugin for tmux. I mean a tmux plugin for vim.
    :S/{vim,tmux}/{tmux,vim}/g

Did you miss it? Watch, as I undo, then redo again: each occurrence of `vim` becomes `tmux`, and vice versa.

### Real world example: asset migration

I'd like to finish by demonstrating how the `:Subvert` command helped me out recently. I was migrating the assets for a website to Amazon's S3 storage and I had to go through all existing content to update the links to assets.

Before the migration, a typical asset path looked like this:

    /assets/102/DSC_0524_normal.JPG

In this case, the nubmer `102` corresponds to the ID of that asset's record in the database. After the migration, the path for the same asset looked like this:

    http://westportbookfestival.s3.amazonaws.com/assets/265/DSC_0524_normal.JPG

On the surface, the transformation looks simple: just prepend the S3 domain in front of every `/assets/` path, but there was a complication. In the process of moving to S3, each asset was assigned a new ID in the database. So I had to replace all of the old IDs with the new ones.

This should be possible using a `:Subvert` command of this form:

    :%Subvert!assets/{former_ids}/!assets/{new_ids}/!g

Which is just a variation on the word swap example we saw a moment ago.

I kept all the information that I needed in a yaml file: which recorded the old and new ID for each asset. 

    - :former_id: 6
      :new_id: 170
    - :former_id: 7
      :new_id: 171
    - :former_id: 8
      :new_id: 172

I massaged these records into two blocks of comma-seperated ids: one containing all of the `former_id`s, the other containing all of the `new_id`s. I won't show the steps involved, but this could be a classic VimGolf challenge!

Then I take this long list of `former_id`s and paste it into the target region of my command. Do the same for the `new_id`s, pasting into the replace region of the Subvert command. That looks pretty crazy, but if I've done it right then this huge command should replace all old asset IDs with their new equivalent.

Of course, I'm not going to type that out! Instead, I'll yank it into register 's', then switch to one of the markdown files to try it out. To run the command, I'll paste register 's' into the command line:

    :%Subvert!assets/{former_ids}/!assets/{new_ids}/!g

That looks good! Let's undo that, then run the same command across the entire arglist, which I've already populated with 5 markdown files.

    argdo %Subvert!assets/{6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,110,112,114,116,118,120,122,124,126,128,130,132,133,134,135,136,137,138,139,140,141,142,143,144,145,147,149,151,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,185,186,187,188,189,190}/!assets/{170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,273,275,277,279,281,283,285,287,289,291,293,295,296,297,298,299,300,301,302,303,304,305,306,307,308,310,312,314,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352}/!gc

That's a pretty epic substitution, and it saved me a heck of a lot of time.
