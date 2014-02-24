class Episode

  attr_accessor :poster

  def initialize(options)
    if options.respond_to?(:data)
      options = options.data
    end
    @poster = options[:poster]
  end

  def poster_url
    @poster.include?(domain) ? @poster : domain + @poster
  end

  private

  def domain
    'http://vimcasts.org'
  end
end
