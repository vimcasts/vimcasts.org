title = "Vimcasts"
author = "Drew Neil"
description = "Regular free screencasts about the Vim text editor."
keywords = "vim, text editor"
image = "http://media.vimcasts.org/posters/vimcasts.png"
ext = 'm4v'
@episodes = blog(:episodes).articles

xml.instruct!
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do
    xml.title title
    xml.link 'http://vimcasts.com'
    xml.description description
    xml.language 'en'
    xml.pubDate @episodes.first.date.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.date.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, :href => image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'drew@vimcasts.com'
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Technology' do
      xml.itunes :category, :text => 'Software How-To'
    end
    xml.itunes :category, :text => 'Education' do
      xml.itunes :category, :text => 'Training'
    end

    @episodes.each do  |article|
      episode = Episode.new(article)
      xml.item do
        xml.title article.title
        xml.description article.summary
        xml.pubDate article.date.to_s(:rfc822)
        xml.enclosure url: episode.quicktime.url,
          length: episode.quicktime.size,
          type: "video/x-m4v"
        xml.link article.path
        xml.guid({:isPermaLink => "false"}, article.path)
        xml.itunes :author, author
        xml.itunes :subtitle, truncate(article.summary, :length => 150)
        xml.itunes :summary, article.summary
        xml.itunes :explicit, 'no'
        xml.itunes :duration, episode.running_time
      end
    end
  end
end
