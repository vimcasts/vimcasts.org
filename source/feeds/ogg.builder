xml.instruct!
xml.rss version: "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Vimcasts OGG Feed"
    xml.description "Vimcasts - Free screencasts about the text editor Vim"
    xml.link "http://vimcasts.org/feeds/ogg/"
    xml.atom :link,
      href:"http://vimcasts.org/feeds/ogg/",
      rel:"self",
      type:"application/rss+xml"
    xml.language "en-us"
    xml.ttl "40"
    aggregate.each do |article|
      xml.item do
        xml.title article.title
        xml.description html_escape(article.summary)
        xml.pubDate article.date.to_time.httpdate
        xml.guid URI.join("http://vimcasts.org", article.url)
        xml.link URI.join("http://vimcasts.org", article.url)
      end
    end
  end
end
