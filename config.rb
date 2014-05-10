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

activate :s3_sync do |s3|
  s3.bucket = 'vimcasts.org'
end

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

set :boxee_feeds, [
  {
    name: "boxee-ogg",
    format: "ogg",
    title: "Vimcasts OGG on Boxee",
    type: "video/ogg",
  },
  {
    name: "boxee-quicktime",
    format: "quicktime",
    title: "Vimcasts Quicktime on Boxee",
    type: "video/x-m4v",
  },
]

set :feeds, [
  {
    name: "ogg",
    format: "ogg",
    title: "Vimcasts OGG Feed",
    type: "video/ogg",
  },
  {
    name: "quicktime",
    format: "quicktime",
    title: "Vimcasts Quicktime Feed",
    type: "video/x-m4v",
  }
]

(feeds + boxee_feeds).each do |feed|
  proxy "/feeds/#{feed[:name]}.rss", "/feeds/all.xml",
    :locals => { :feed => feed },
    :ignore => true,
    layout: false
end

page "/feeds/itunes.xml", layout: false

(feeds + boxee_feeds).each do |feed|
  redirect "feeds/#{feed[:name]}/index.html", to: "feeds/#{feed[:name]}.rss"
end
redirect "feeds/itunes/index.html", to: "feeds/itunes.xml"

page "/episodes.json", layout: false
page "sitemap.xml",    layout: false

ignore 'bower_components/*'

###
# Compass
###

compass_config do |config|
  # Require any additional compass plugins here.
  config.add_import_path "bower_components/foundation/scss"
  config.add_import_path "bower_components/RRSSB/scss"

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

proxy "/episodes/archive.html", "/episodes-all.html", ignore: true

# Generate data/categories.yml with `rake dump_categories`
if data.has_key? :categories
  data.categories.each do |tag|
    name = tag[:name]
    slug = tag[:slug]
    proxy "categories/#{slug}.html", "category-aggregate.html", locals: { tagname: name }, ignore: true
  end
end

# A tag is invisible until it is used to label N or more items
set :tag_visiblity_threshold, 2

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
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

end

# Uncomment next line to use Pry as a console
# ready { binding.pry }

# Layouts and redirects:
page "/transcripts/*/en.html", layout: "transcript"
redirect "e/a.html", to: "/episodes/archive"
redirect "transcripts/index.html", to: "/episodes/archive"

ready do

  blog(:episodes).articles.each do |a|
    page a.path, layout: 'screencast'
    n = a.data.number
    redirect "e/#{n}/index.html", to: "/#{a.path}"
    redirect "e/#{n}/t/index.html", to: "/transcripts/#{n}/en"
    redirect "episodes/#{n}/index.html", to: "/#{a.path}"
  end

  blog(:blog).articles.each do |a|
    page a.path, layout: 'article'
    # FIXME: this raises an error:
    #   needs a date in its filename or frontmatter (RuntimeError)
    # redirect a.path, to: a.destination_path
  end

  blog(:announcements).articles.each do |a|
    page a.path, layout: 'announcement'
  end

end
