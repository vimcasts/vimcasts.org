gem "minitest"
require 'minitest/autorun'
require_relative '../lib/episode'
require 'ostruct'

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
      assert_equal '12', Episode.new({number: 12}).number
      assert_equal '42', Episode.new(OpenStruct.new(data: {number: 42})).number
    end
  end
end
