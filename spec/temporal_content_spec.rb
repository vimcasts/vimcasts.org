gem "minitest"
require 'minitest/autorun'
require_relative '../lib/temporal_content'

module TemporalContent
  jan1 = Date.parse("2014-01-01")
  feb1 = Date.parse("2014-02-01")
  mar1 = Date.parse("2014-03-01")
  apr1 = Date.parse("2014-04-01")
  rootpath = File.join("spec","_temporal")

  describe TemporalContent do
    it '#get returns a source file' do
      result = TemporalContent.get('next-event', jan1, rootpath)
      assert_equal "spec/_temporal/next-event/_2014-01-27.md", result.path
    end

    describe Theme do

      it '#items returns all Items' do
        theme = Theme.new('next-event', rootpath)
        dates = [
          Date.parse("2014-01-27"),
          Date.parse("2014-02-19"),
          Date.parse("2014-03-05"),
          :never
        ]
        assert_equal dates, theme.items.map(&:expiry_date)
      end

      it '#current_items returns items that haven\'t expired' do
        theme = Theme.new('next-event', rootpath)
        dates = [
          Date.parse("2014-01-27"),
          Date.parse("2014-02-19"),
          Date.parse("2014-03-05"),
          :never
        ]
        assert_equal dates, theme.current_items(jan1).map(&:expiry_date)
        assert_equal dates[1..-1], theme.current_items(feb1).map(&:expiry_date)
        assert_equal dates[2..-1], theme.current_items(mar1).map(&:expiry_date)
        assert_equal dates[3..-1], theme.current_items(apr1).map(&:expiry_date)
      end

    end

    describe Item do

      it '#path reads attribute' do
        path = 'spec/_temporal/next-event/_2014-01-27.md'
        example = Item.new(path)
        assert_equal path, example.path
      end

      it '#partial_path strips ^source and .md$ from path' do
        path = 'spec/_temporal/next-event/_2014-01-27.md'
        example = Item.new(path)
        assert_equal '_temporal/next-event/2014-01-27', example.partial_path
      end

      it '#expiry_date is derived from pathname' do
        example = Item.new('spec/_temporal/next-event/_2014-01-27.md')
        assert_equal Date.parse("2014-01-27"), example.expiry_date
      end

      it '#expiry_date is :never for default content' do
        example = Item.new('spec/_temporal/next-event/_default.md')
        assert_equal :never, example.expiry_date
      end

      it '#current? when expiry_date is before cutoff' do
        example = Item.new('spec/_temporal/next-event/_2014-01-27.md')
        assert example.current?(Date.parse("2014-01-26"))
        assert example.current?(Date.parse("2014-01-27"))
        refute example.current?(Date.parse("2014-01-28"))
      end

      it '#current? is always true for default content' do
        example = Item.new('spec/_temporal/next-event/_default.md')
        assert example.current?(Date.parse("2014-01-26"))
      end

      it '#<=> compares dates numerically' do
        first = Item.new('spec/_temporal/next-event/_2014-01-27.md')
        second = Item.new('spec/_temporal/next-event/_2014-03-05.md')
        assert(first < second)
        assert(first == first)
      end

      it '#<=> compares dates numerically' do
        first = Item.new('spec/_temporal/next-event/_2014-01-27.md')
        default = Item.new('spec/_temporal/next-event/_default.md')
        assert(first < default)
        refute(default < first)
      end

    end

  end
end
