module Middleman
  class Aggregator < Extension
    def initialize(app, options_hash={}, &block)
      super
    end
    helpers do
      def aggregate
        (blog(:episodes).articles + blog(:blog).articles).sort_by(&:date).reverse
      end
      def minute_second(seconds)
        min, sec = *seconds.divmod(60)
        [min, sec.to_s.rjust(2, '0')].join(':')
      end
    end
  end
  ::Middleman::Extensions.register(:aggregator, Aggregator)
end

