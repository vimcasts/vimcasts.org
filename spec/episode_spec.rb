gem "minitest"
require 'minitest/autorun'
require_relative '../lib/episode'
require 'ostruct'

def registry
  'spec/video_metadata.json'
end

describe Episode do

  describe 'constructor' do

    it 'handles a hash argument' do
      episode = Episode.new({poster: '/images/posters/show_invisibles.png'})
      assert_equal  '/images/posters/show_invisibles.png', episode.poster
    end

    it 'handles an object that receives .data' do
      page = OpenStruct.new(data: {poster: '/images/posters/show_invisibles.png'})
      episode = Episode.new(page)
      assert_equal  '/images/posters/show_invisibles.png', episode.poster
    end

  end

  describe 'episode_url' do

    it 'generates URL from path' do
      episode = Episode.new({poster: '/images/posters/show_invisibles.png'})
      assert_equal 'http://vimcasts.org/images/posters/show_invisibles.png', episode.poster_url
    end

    it 'generates URL from path' do
      episode = Episode.new({poster: 'http://vimcasts.org/images/posters/show_invisibles.png'})
      assert_equal 'http://vimcasts.org/images/posters/show_invisibles.png', episode.poster_url
    end

  end

  describe 'running_time' do
    it 'converts seconds into mm:ss' do
      assert_equal  '0:55', Episode.new({duration:  '55'}).running_time
      assert_equal  '1:01', Episode.new({duration:  '61'}).running_time
      assert_equal '10:11', Episode.new({duration: '611'}).running_time
    end
  end

  describe 'running_datetime' do
    it 'converts seconds into mm:ss' do
      assert_equal  'P0M,55S', Episode.new({duration:  '55'}).running_datetime
      assert_equal  'P1M,01S', Episode.new({duration:  '61'}).running_datetime
    end
  end

  describe 'number' do
    it 'returns -1 when episode has no number' do
      assert_equal '-1', Episode.new().number
    end
    it 'returns given number' do
      assert_equal '12', Episode.new({number: 12}, registry).number
      assert_equal '12', Episode.new(OpenStruct.new(data: {number: 12}), registry).number
    end
  end

  describe 'ogg' do
    it 'maps to a VideoFile object' do
      episode = Episode.new(ogg: {url: 'http://media.vimcasts.org/videos/1/show_invisibles.ogv'})
      assert_equal VideoFile, episode.ogg.class
    end

    it 'looks up video metadata indexed by number' do
      episode = Episode.new({number: 12}, registry)
      assert_equal 'http://othermedia.vimcasts.org/videos/12/modal_editing.ogv', episode.ogg.url
      assert_equal 1234567, episode.ogg.size
    end
  end

  describe 'quicktime' do
    it 'maps to a VideoFile object' do
      episode = Episode.new(quicktime: {url: 'http://media.vimcasts.org/videos/1/show_invisibles.ogv'})
      assert_equal VideoFile, episode.quicktime.class
    end
  end

end

describe VideoFile do
  describe 'constructor' do
    it 'can receive url and size directly' do
      ogg = VideoFile.new(:ogg, {
        "duration" => 123,
        "ogg" => {
          "url" => "http://media.vimcasts.org/videos/12/modal_editing.ogv",
          "size" => 5036160
        }
      })
      assert_equal 'http://media.vimcasts.org/videos/12/modal_editing.ogv', ogg.url
      assert_equal 5036160, ogg.size
      assert_equal 123, ogg.duration
    end

    it 'can derive url and size by looking up metadata registry' do
      ogg = VideoFile.new(:ogg, {:number => 12}, 'spec/video_metadata.json')
      assert_equal 'http://othermedia.vimcasts.org/videos/12/modal_editing.ogv', ogg.url
      assert_equal 1234567, ogg.size
      assert_equal 326, ogg.duration
    end
  end
end
