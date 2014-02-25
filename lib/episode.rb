class Episode

  attr_accessor :poster

  def initialize(options)
    if options.respond_to?(:data)
      options = options.data
    end
    @poster = options[:poster]
    @duration = options[:duration].to_i
  end

  def poster_url
    @poster.include?(domain) ? @poster : domain + @poster
  end

  def running_time
    [mins, secs.to_s.rjust(2, '0')].join(':')
  end

  def running_datetime
    ["P#{mins}M", "#{secs.to_s.rjust(2, '0')}S"].join(',')
  end

  private

  def domain
    'http://vimcasts.org'
  end

  def mins
    @duration.divmod(60)[0]
  end

  def secs
    @duration.divmod(60)[1].to_s.rjust(2, '0')
  end

end
