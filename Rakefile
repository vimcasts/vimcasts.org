require 'middleman-gh-pages'

task :dump_categories do
  require 'middleman-blog'
  @app =::Middleman::Application.server.inst
  tags = (@app.blog(:blog).tags.keys + @app.blog(:episodes).tags.keys).uniq
  File.open('data/categories.yml', 'w') do |f|
    f.write tags.to_yaml
  end
end
