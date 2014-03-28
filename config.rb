require 'pry'
require 'lib/episode'
require 'lib/similar'
require 'lib/temporal_content'
require 'lib/aggregator'
activate :aggregator
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

I18n.enforce_available_locales = false

###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = "blog"
  blog.sources = "{title}.html"
  blog.permalink = "{year}/{month}/{title}.html"
  blog.summary_separator = /<p>READMORE<\/p>/
  blog.paginate = true
  blog.year_template = "archive-by-year.html"
  blog.month_template = "archive-by-month.html"
  blog.taglink = "/categories/{tag}.html"
  blog.summary_length = nil
end

activate :blog do |blog|
  blog.name = "episodes"
  blog.prefix = "episodes"
  blog.sources = "{number}-{title}.html"
  blog.permalink = "{title}.html"
  blog.summary_separator = /<p>READMORE<\/p>/
  blog.paginate = true
  blog.taglink = "/categories/{tag}.html"
  blog.summary_length = nil
end

activate :blog do |blog|
  blog.name = "announcements"
  blog.prefix = "announcements"
  blog.sources = "{title}.html"
  blog.permalink = "{year}/{month}/{title}.html"
  blog.summary_separator = /<p>READMORE<\/p>/
  blog.paginate = true
  blog.year_template = "archive-by-year.html"
  blog.month_template = "archive-by-month.html"
  blog.summary_length = nil
end

set :feeds, [
  {
    name: "ogg",
    title: "Vimcasts OGG Feed",
    type: "video/ogg",
  },
  {
    name: "quicktime",
    title: "Vimcasts Quicktime Feed",
    type: "video/x-m4v",
  }
]

feeds.each do |feed|
  proxy "/feeds/#{feed[:name]}.rss", "/feeds/all.xml",
    :locals => { :feed => feed },
    :ignore => true,
    layout: false
end
proxy "/feeds/itunes", "/feeds/itunes.xml", layout: false

page "/episodes.json", layout: false
page "sitemap.xml",    layout: false

ignore 'bower_components/*'

###
# Compass
###

compass_config do |config|
  # Require any additional compass plugins here.
  config.add_import_path "bower_components/foundation/scss"

  # Set this to the root of your project when deployed:
  config.http_path = "/"
  config.css_dir = "stylesheets"
  config.sass_dir = "stylesheets"
  config.images_dir = "images"
  config.javascripts_dir = "javascripts"

  # You can select your preferred output style here (can be overridden via the command line):
  # output_style = :expanded or :nested or :compact or :compressed

  # To enable relative paths to assets via compass helper functions. Uncomment:
  # relative_assets = true

  # To disable debugging comments that display the original location of your selectors. Uncomment:
  # line_comments = false


  # If you prefer the indented syntax, you might want to regenerate this
  # project again passing --syntax sass, or you can uncomment this:
  # preferred_syntax = :sass
  # and then run:
  # sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

end

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

def extract_number_from_path(glob)
  Dir[glob].map { |path| path.slice(/\d+/) }
end

glob = File.join("source", "transcripts", "*", "en.md")
extract_number_from_path(glob).each do |number|
  proxy "/episodes/#{number}/transcript.html", "/transcripts/#{number}/en.html"
end

languages = %w{fr}
languages.each do |lang|
  glob = File.join("source", "transcripts", "*", "#{lang}.md")
  extract_number_from_path(glob).each do |number|
    proxy "/episodes/#{number}/transcript/#{lang}.html", "/transcripts/#{number}/#{lang}.html"
  end
end

proxy "/episodes/archive.html", "/episodes-all.html", ignore: true

# Generate data/categories.yml with `rake dump_categories`
if data.has_key? :categories
  data.categories.each do |tag|
    category = tag[:name]
    proxy "categories/#{category}.html", "category-aggregate.html", locals: { tagname: category }, ignore: true
  end
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :directory_indexes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Redirects
  ready do
    redirect "e/a.html", to: "/episodes/archive"
    blog(:episodes).articles.each do |episode|
      n = episode.data.number
      redirect "episodes/#{n}.html", to: "/#{episode.path}"
      redirect "e/#{n}.html", to: "/#{episode.path}"
      redirect "e/#{n}/t.html", to: "/episodes/#{n}/transcript"
    end

    # FIXME: this raises an error:
    #   needs a date in its filename or frontmatter (RuntimeError)
    # blog(:announcements).articles.each do |a|
    #   year, month = a.date.strftime('%Y %m').split(' ')
    #   redirect "blog/#{year}/#{month}/#{a.slug}.html", to: "/#{a.path}"
    # end

    # blog(:blog).articles.each do |post|
    #   redirect post.path, to: post.destination_path
    # end
  end

end

# Uncomment next line to use Pry as a console
# ready { binding.pry }

# Layouts:
page "/transcripts/*/en.html", layout: "transcript"
ready do
  blog(:episodes).articles.each do |a|
    page a.path, layout: 'episode'
  end
  blog(:blog).articles.each do |a|
    page a.path, layout: 'blogpost'
  end
  blog(:announcements).articles.each do |a|
    page a.path, layout: 'announcement'
  end
end
