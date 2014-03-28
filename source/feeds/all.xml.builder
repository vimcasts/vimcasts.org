xml.instruct!
xml.rss version: "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title feed[:title]
    xml.description "Vimcasts - Free screencasts about the text editor Vim"
    xml.link "http://vimcasts.org/feeds/#{feed[:name]}/"
    xml.atom :link,
      href:"http://vimcasts.org/feeds/#{feed[:name]}/",
      rel:"self",
      type:"application/rss+xml"
    xml.language "en-us"
    xml.ttl "40"
    aggregate.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.summary
        episode = Episode.new(article)
        unless episode.number == '-1'
          xml.enclosure url: episode.send(feed[:name]).url,
            length: episode.send(feed[:name]).size,
            type: feed[:type]
        end
        xml.pubDate article.date.to_time.httpdate
        xml.guid URI.join("http://vimcasts.org", article.url)
        xml.link URI.join("http://vimcasts.org", article.url)
      end
    end
  end
end
