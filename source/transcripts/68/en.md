Here, I've got some tests written with rspec.
I'd like to wrap these lines inside of a context block:

    subject(:order) { Order.new(basic_attributes) }
    it "records the buyer's name" do
      expect(order.buyer_name).to be == "Drew Neil"
    end
    it "has no affiliate_email" do
      expect(order.affiliate_email).to be == 'none'
    end

Normally that would take three separate steps:

* create a new line above to open the context block
* create a new line below to close the block, then
* clean up by fixing the indentation

Let's set up an UltiSnips snippet to speed up this process. We'll use the word `context` as the trigger:

    snippet context "rspec: context block"
    context "$1" do
    	${VISUAL}
    end
    endsnippet

We'll use the dollar-one placeholder to position the cursor inside the quotes after expanding the snippet.
Inside of the context block, we'll use the special `$VISUAL` placeholder to insert the text that was selected in visual mode before the snippet was expanded.
Also, we'll use a tab character at the start of the line to indicate that the selected text should be indented by one extra level.

You can think of a tab character as representing one press of the tab key: it inserts either a tab character or a fixed number of spaces, depending on how you've set up Vim's 'expandtab' option.

Let's switch back to our spec file.
I'll revert our previous edit: note that I have to press undo thrice, because I made 3 individual changes.

Now let's make the same change using the snippet that we just created.
I'll select the lines that I want to wrap in the context block, then hit the tab key, type my trigger word, and when I expand the snippet you'll see that the text we had highlighted appears inside of the context block, with one additional level of indentation.

This time, I can revert the change with a single undo, or repeat with a single redo. I consider that an improved workflow.

The `$VISUAL` placeholder is especially useful in situations like this, where you want to wrap something before and after a block of text that's already present in your document.

This snippet works great when triggered from Visual mode, but watch what happens when I expand it from Insert mode: the context block is empty, and the final tabstop is after the context block. It would be more convenient if the cursor was positioned inside of the context block.

Let's adapt our snippet to do this.
We'll use the dollar-zero placeholder to set the final tabstop inside of the context block.
If the snippet is triggered from Visual mode, it'll insert the selected text.
But if the snippet is triggered from Insert mode, it'll fall back to use the default text specified here.

    snippet context "rspec: context block"
    context "$1" do
    	${0:${VISUAL:# assertions...}}
    end
    endsnippet

Now our snippet is useful whether we trigger it from Visual mode or from inserts mode.

### Transforming the selection with Python interpolation

In C++, suppose that we want to turn a simple pointer (like this):

    // Simple pointer:
    Vim* cursor;

Into a smart pointer (like this):

    // Smart pointer:
    std::unique_ptr<Vim> cursor;

We could use this simple snippet to speed up the process:

    snippet up "Unique Pointer" i
    std::unique_ptr<${1:${VISUAL:klass}}>
    endsnippet

Now watch: I'll select the name of the pointer that I want to modify, hit tab, type the trigger word, and expand the snippet. That's a neat workflow, but notice that we're left with this asterisk which we then have to delete by hand.

To improve upon this workflow, we could use UltiSnips Python interpolation feature.

In a Python interpolation block, we can access the text that was visually selected through the `snip.v.text` object. We'll use Python's `.strip()` method to remove the asterisk character.

    snippet up "Unique Pointer" i
    std::unique_ptr<${1:`!p
    snip.rv = snip.v.text.strip("*") or "klass"
    `}>
    endsnippet

Now let's try it out. This time, I need to select the pointer name and the asterisk. I'll hit tab, type the trigger word, and expand the snippet. Our new and improved snippet has stripped out the asterisk, so this time we needn't perform any additional clean up.
