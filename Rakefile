require 'middleman-gh-pages'

desc 'Build a list of tags and save it to data/categories.yml'
task :categories do
  require 'middleman-blog'
  @app = ::Middleman::Application.server.inst
  blog_tags = @app.blog(:blog).tags
  episode_tags = @app.blog(:episodes).tags
  tags = (blog_tags.keys + episode_tags.keys).uniq
  tagdata = tags.map do |tag|
    videos   = episode_tags.fetch(tag, []).count
    articles = blog_tags.fetch(tag, []).count
    {
      name: tag,
      videos: videos,
      articles: articles,
      total: videos+articles
    }
  end.sort_by { |k| k[:total] }.reverse
  File.open('data/categories.yml', 'w') do |f|
    f.write tagdata.to_yaml
  end
end

desc 'Prepare, build, and publish to gh-pages'
task :shipit => [:categories, :publish]
