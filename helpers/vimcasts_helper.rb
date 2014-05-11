require 'open-uri'

module VimcastsHelper

  def extended_article(article)
    separator = blog(:episodes).options[:summary_separator]
    article.render(layout: false, keep_separator: true).split(separator).last
  end

  def number_of_core_vim_attendees
    data.has_key?(:core_vim) ? data.core_vim.alumni : '500'
  end

  def price_of_core_vim_course
    '120'
  end

  def link_to_article_tags(taglist)
    taglist.map do |tag|
      link_to tag[:name], "/categories/#{tag[:slug]}"
    end.join(", ")
  end

  def article_type(article)
    {
      'blog' => 'article',
      'episodes' => 'screencast',
      'announcements' => 'announcement'
    }[article.blog_options[:name]]
  end

  def tag_stats(tag, connector=", ")
    tag = tag_details(tag) if tag.class == String
    [
      [:videos, 'screencast'],
      [:articles, 'article']
    ].map do |key, word|
      if (number = tag[key]) > 0
        pluralize(number, word).sub(' ','&nbsp;')
      end
    end.compact.join(connector)
  end

  def tag_details(name)
    data.categories.select { |c| c["name"] == name }.first
  end

  def domain
    environment == :development ? 'http://localhost:4567' : 'http://vimcasts.org'
  end

  def transcript_for_episode(number)
    "/transcripts/#{number}/en/"
  end

  def announcement(name, now=Date.today)
    partial TemporalContent.get(name, now).partial_path
  end

  def continue?(article)
    return false unless has_extended_text?(article)
    if article.blog_options[:name] == "episodes"
      "<span class='icon-play icomoon'></span>Watch screencast"
    else
      "<span class='icon-book icomoon'></span>Continue reading"
    end
  end

  def has_extended_text?(article)
    File.readlines(article.source_file).any? do |line|
      line.match /READMORE/
    end
  end

  def episode_from_transcript(page)
    number = page.path.slice(/\d+/).to_i
    blog(:episodes).articles.select { |a| a.data["number"] == number }.first
  end

  def force_absolute_links(input)
    input.gsub(/href="\//) { |m| "href=\"#{domain}/" }
  end

  def cleanup_html(input)
    result = force_absolute_links(input)
  end

  def share_by_email(page)
    subject = URI::encode(page.title)
    body    = URI.encode_www_form_component(URI.join(domain, page.url))
    "mailto:?subject=#{subject}&amp;body=#{body}"
  end

  def share_by_twitter(page)
    status = [URI::encode(page.title), URI.join(domain, page.url)].join(" ")
    "http://twitter.com/home?status=#{status}"
  end

  def share_by_facebook(page)
    "https://www.facebook.com/sharer/sharer.php?u=#{URI.join(domain, page.url)}"
  end

  def share_by_googleplus(page)
    message = [URI::encode(page.title), URI.join(domain, page.url)].join(" ")
    "https://plus.google.com/share?url=#{message}"
  end

  def proof_mode
    " proof" if config.environment == :development
  end

  def format_pubdate(page)
    shortform = page.date.strftime("%b&nbsp;%e, '%y")
    longform  = page.date.strftime("%b %e, %Y")
    [
      content_tag(:div, shortform, class: 'hide-for-medium-up'),
      content_tag(:div, longform,  class: 'show-for-medium-up')
    ].join
  end

  def episode_archive_listing
    blog(:episodes).articles.group_by do |a|
      { year: a.date.year, month: a.date.strftime("%B") }
    end
  end

  def show_subnav
    pattern = /^#{["categories", "episodes", "blog"].join("|")}/
    pattern === current_page.request_path
  end

  def navigation_link(text, path, &block)
    destination = path.sub(/^\//, '')
    location = current_page.request_path.sub(/\/index\.html/, '')
    if location == destination
      # the current page is the page being linked to
      status = "active"
    elsif location.index(destination) == 0
      # the current page is a child of the page being linked to
      status = "open"
    end

    content = capture(&block) if block_given?
    content_tag :li, class: status do
      [link_to(text, path), content].join
    end
  end

  def homepage?
    current_page.request_path == "index.html"
  end

  def visible_tags(tagnames, threshold)
    data.categories.select do |tag|
      tagnames.include?(tag["name"]) && tag["total"] >= threshold
    end
  end

  def adjacent(direction=:next)
    if item = current_page.send("#{direction}_article")
      {
        path: "/" + item.destination_path.sub(/index\.html$/, ""),
        title: item.title
      }
    end
  end

end
