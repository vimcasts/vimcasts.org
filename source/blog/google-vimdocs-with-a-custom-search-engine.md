--- 
:title: Google vimdocs with a custom search engine
:date: 2013/02/15

---

Here's a quick tip: if you can't find what you're looking for in Vim's built-in documentation, use a search engine instead. All of Vim's documentation is online at [vimdoc.sourceforge.net][h], so it's indexed by Google & Co. If you create a [custom search engine][chrome] for your browser, then you can easily limit your searches to only return results from [vimdoc.sourceforge.net][h].

[h]: http://vimdoc.sourceforge.net/htmldoc/
[chrome]: http://support.google.com/chrome/bin/answer.py?hl=en&answer=95653
[so]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#search-offset


READMORE

<r:snippet name="announcement"/>

You can [add a custom search engine in Chrome][chrome] by right-clicking on the address bar (or holding the ctrl key while clicking it), then selecting the "Edit Search engines..." item from the contextual menu. That opens up a settings tab where you can edit your custom search engines:

![Custom search engines in Google Chrome](/images/blog/chrome-search-engines.png)

I've created a Vimdocs search engine with the following values:

    name: Vimdocs
    keyword: v
    URL: http://www.google.com/search?q=%s+site:http://vimdoc.sourceforge.net

The `%s` item in the URL is a placeholder that will be replaced with whatever text I enter when I use this custom search engine.

Suppose that I want to find the documentation on [`search offsets`][so]. I press `cmd-L` to focus the address bar, then I type `v` followed by a space. The address bar brings up a prompt to indicate that I'm using the custom Vimdocs search engine:

![The address bar shows a Vimdocs prompt](/images/blog/vim-search-engine-prompt.png)

After typing my query, I hit enter and it shows the search engine results page:

![Google says: 'did you mean "search offset"?'](/images/blog/vim-SERPs.png)

Note that I mis-spelled *search* and *offset*, but Google guessed what I wanted and served the results for my corrected query. Search engines are more liberal in what they accept than Vim's built-in `:help` and `:helpgrep` commands.

This trick is especially useful if you don't know the helptag for the item that you want to know more about. If you can come up with a query that contains enough words to identify the right page of the documentation, then you can usually find what you're looking for.

[h]: http://vimdoc.sourceforge.net/htmldoc/
[chrome]: http://support.google.com/chrome/bin/answer.py?hl=en&answer=95653
[so]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#search-offset
[firefox]: http://support.mozilla.org/en-US/kb/search-web-address-bar