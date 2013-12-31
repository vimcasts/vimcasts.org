module Middleman
  class Aggregator < Extension
    def initialize(app, options_hash={}, &block)
      super
    end
    helpers do
      def aggregate
        (blog(:episodes).articles + blog(:blog).articles).sort_by(&:date).reverse
      end
    end
  end
  ::Middleman::Extensions.register(:aggregator, Aggregator)
end

