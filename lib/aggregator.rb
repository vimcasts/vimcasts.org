module Middleman
  class Aggregator < Extension
    def initialize(app, options_hash={}, &block)
      super
    end
    helpers do
      def aggregate
        (blog(:episodes).articles + blog(:blog).articles).sort_by(&:date).reverse
      end

      def aggregate_by_tag(tagname)
        (blog(:episodes).tags.fetch(tagname,[]) + blog(:blog).tags.fetch(tagname,[])).sort_by(&:date)
      end

      def minute_second(seconds)
        min, sec = *seconds.divmod(60)
        [min, sec.to_s.rjust(2, '0')].join(':')
      end
    end
  end
  ::Middleman::Extensions.register(:aggregator, Aggregator)
end

