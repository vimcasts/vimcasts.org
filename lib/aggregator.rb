module Middleman
  class Aggregator < Extension
    def initialize(app, options_hash={}, &block)
      super
    end
    helpers do
      def aggregate(blogs=[:episodes, :blog, :announcements])
        all_articles = blogs.map { |name| blog(name).articles }
        all_articles.flatten.sort_by(&:date).reverse
      end

      def aggregate_by_tag(tagname, blogs=[:episodes, :blog])
        tagged_articles = blogs.map { |name|
          blog(name).tags.fetch(tagname,[])
        }
        tagged_articles.flatten.sort_by(&:date)
      end

      def minute_second(seconds)
        min, sec = *seconds.divmod(60)
        [min, sec.to_s.rjust(2, '0')].join(':')
      end
    end
  end
  ::Middleman::Extensions.register(:aggregator, Aggregator)
end

