---
:title: Using selected text in UltiSnips snippets
:date: 2014/07/23
:poster: /images/posters/ultisnips-selections.png
:duration: 313
:number: 68
:tags: Visual mode, plugins
---

When UltiSnips is triggered from Visual mode it captures the selection and makes it available to our snippets. We can then insert the selection unchanged with the `$VISUAL` placeholder, or we can use UltiSnips Python interpolation to transform the text before inserting it back into the document.

READMORE

Suppose that we've got some tests written with rspec:

```ruby
subject(:order) { Order.new(basic_attributes) }
it "records the buyer's name" do
  expect(order.buyer_name).to be == "Drew Neil"
end
it "has no affiliate_email" do
  expect(order.affiliate_email).to be == 'none'
end
```

We want to wrap them inside of a `context` block:

```ruby
context "with no affiliate" do
  subject(:order) { Order.new(basic_attributes) }
  it "records the buyer's name" do
    expect(order.buyer_name).to be == "Drew Neil"
  end
  it "has no affiliate_email" do
    expect(order.affiliate_email).to be == 'none'
  end
end
```

We could make this change quickly using this UltiSnips snippet:

    snippet context "rspec: context block"
    context "$1" do
    	${0:${VISUAL:# assertions...}}
    end
    endsnippet

This snippet can be used in Insert mode or Visual mode. When triggered from Insert mode, the context block is pre-filled with the default placeholder text: `# assertions`. But if we start off by selecting several lines of text, then trigger the snippet from Visual mode, the context block will be pre-filled with the text that we had selected. That's what the `$VISUAL` placeholder is for.

Note that in the above snippet, the line inside of the context block begins with a tab character, which causes the selected text to be inserted with and extra level of indentation. You can think of a tab character as representing one press of the tab key: it inserts either a tab character or a fixed number of spaces, depending on how you've set up Vim's 'expandtab' option. (See [episode 2 of Vimcasts][2] for more details of how the 'expandtab' option works.)

### Transforming the selection with Python interpolation

In C++, suppose that we want to turn a simple pointer (like this):

    // Simple pointer:
    Vim* cursor;

Into a smart pointer (like this):

    // Smart pointer:
    std::unique_ptr<Vim> cursor;

We could use this snippet to speed up the process:

    snippet up "Unique Pointer" i
    std::unique_ptr<${1:`!p
    snip.rv = snip.v.text.strip("*") or "klass"
    `}>
    endsnippet

Here, we're using UltiSnips Python interpolation feature to transform the selected text before inserting it back into the document. That means that we can select the text `Vim*` (including the star character), then when we expand the snippet it will insert `Vim` (having stripped away the star character).

### Further reading

* `:h UltiSnips-visual-placeholder`
* `:h UltiSnips-python`
* [Episode #66: Meet UltiSnips][66]
* [Episode #67: Using Python interpolation in UltiSnips snippets][67]
* [Episode #2: Tabs and Spaces][2]

[2]: /e/2
[66]: /e/66
[67]: /e/67
