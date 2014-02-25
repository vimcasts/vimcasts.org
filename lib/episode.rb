require 'json'

class VideoFile

  attr_reader :url, :size, :duration

  def initialize(key, data, metadata_registry='')
    @registry = metadata_registry
    if metadata = data[key.to_s]
      @url = metadata["url"]
      @size = metadata["size"]
      @duration = data["duration"]
    elsif index = data[:number]
      metadata = load_video_metadata[index.to_s]
      @url = metadata[key.to_s]["url"]
      @size = metadata[key.to_s]["size"]
      @duration = metadata["duration"]
    end
  end

private

  def load_video_metadata
    return unless File.exist?(@registry)
    File.open(@registry, 'r') do |f|
      JSON.load(f)
    end
  end

end

class Episode

  attr_accessor :poster, :number, :ogg, :quicktime

  def initialize(options={}, metadata_registry='data/videos.json')
    if options.respond_to?(:data)
      options = options.data
    end
    @poster = options[:poster]
    @duration = options[:duration].to_i
    @number = (options[:number] || -1).to_s
    @ogg = VideoFile.new(:ogg, options, metadata_registry)
    @quicktime = VideoFile.new(:quicktime, options, metadata_registry)
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
