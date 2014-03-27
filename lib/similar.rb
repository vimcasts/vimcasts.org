module Similar
  # suggester = Similar::Suggester.new(@app)
  # suggestions.get(article, 4)
  class Suggester < Struct.new(:app)

    # Given an article
    # Return a list of "Related content", drawn from
    # list of similar (by tag) and recent (by date).
    # The list should not include the original article
    # Crop the list to contain the specified count
    def get(article, count=2)
      items = (related(article, count) + recent).uniq
      (items - [article]).first(count)
    end

    # Given an article
    # Return similar articles (with 1+ common tags):
    # the predecessor and successor(s) as sorted by date
    # Note: the list will include the original article
    def related(article, count)
      candidates = similar(article)
      return [] if candidates.empty?
      target = candidates.index(article)
      indexes(count).map do |index|
        candidates[(target+index) % candidates.length]
      end
    end

    # Given an article (from :blog or :episodes)
    # Return a list of articles (from :blog and :episodes)
    # that have at least one tag in common with
    # the specified article, sorted by date
    # Note: the list will include the original article
    def similar(article)
      article.tags.map do |tag|
        [
          app.blog(:episodes).tags.fetch(tag, []),
          app.blog(:blog).tags.fetch(tag, [])
        ]
      end.flatten.uniq.sort_by { |e|
        e.data.date
      }
    end

    # Return a list of recent articles/episodes
    # Note: the list may include the original article
    def recent
      [
        app.blog(:episodes).articles.first(2),
        app.blog(:blog).articles.first(2)
      ].flatten.sort_by { |e|
        e.data.date
      }
    end

    private

    def indexes(count)
      (-1...count).to_a
    end

  end
end
