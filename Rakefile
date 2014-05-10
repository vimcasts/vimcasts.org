require 'json'

desc 'List housekeeping chores'
task :housekeeping do
  require 'middleman-blog'
  @app = ::Middleman::Application.server.inst
  [:episodes, :blog].each do |name|
    untagged = @app.blog(name).articles.select { |a|
      a.tags.size == 0
    }
    if untagged.size > 0
      puts "\nAdd tags to these #{name == :blog ? 'blog posts' : name}:"
      puts untagged.map(&:path)
    end
  end
end

desc 'Build a list of tags and save it to data/categories.yml'
task :categories do
  require 'middleman-blog'
  @app = ::Middleman::Application.server.inst
  blog_tags = @app.blog(:blog).tags
  episode_tags = @app.blog(:episodes).tags
  tags = (blog_tags.keys + episode_tags.keys).uniq
  tagdata = tags.map do |tagname|
    videos   = episode_tags.fetch(tagname, []).count
    articles = blog_tags.fetch(tagname, []).count
    tagslug = tagname.gsub(/\s/, '-').downcase
    {
      name: tagname,
      slug: tagslug,
      videos: videos,
      articles: articles,
      total: videos+articles
    }
  end.sort_by { |k| k[:total] }.reverse
  File.open('data/categories.yml', 'w') do |f|
    f.write tagdata.to_yaml
  end
end

desc 'Create a data/videos.yml file from episodes frontmatter'
task :video_metadata do
  require 'middleman-blog'
  @app = ::Middleman::Application.server.inst
  metadata = {}
  @app.blog(:episodes).articles.each do |e|
    metadata[e.data.number] = {
      duration: e.data.duration,
      ogg: {
        url: e.data.ogg.url,
        size: e.data.ogg[:size],
      },
      quicktime: {
        url: e.data.quicktime.url,
        size: e.data.quicktime[:size],
      }
    }
  end
  File.open('data/videos.json', 'w') do |f|
    f.write JSON.pretty_generate metadata
  end
end

namespace :data do
  desc 'Fetch current data/videos.json from Vimcasts media server'
  task :videos do
    require 'net/http'
    Net::HTTP.start("media.vimcasts.org") do |http|
      resp = http.get("/videos/index.json")
      open("data/videos.json", "w") { |file| file.write(resp.body) }
    end
  end
end

desc 'Publish this site to Amazon S3'
task :publish do
  system "bundle exec middleman s3_sync"
end

desc 'Prepare, build, and publish to gh-pages'
task :shipit => ["data:videos", :categories, :publish]
