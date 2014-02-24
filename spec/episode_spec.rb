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
end
