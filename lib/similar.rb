module Similar
  # suggester = Similar::Suggester.new(@app)
  # suggestions.get(article, 4)
  class Suggester < Struct.new(:app)

    # Given an article
    # Return two similar articles (with >0 common tags):
    # the predecessor and successor(s) as sorted by date
    def get(article, count=2)
      candidates = similar(article)
      return [] if candidates.empty?
      target = candidates.index(article)
      indexes(count).map do |index|
        candidates[(target+index) % candidates.length]
      end.uniq
    end

    # Given an article (from :blog or :episodes)
    # Return a list of articles (from :blog and :episodes)
    # that have at least one tag in common with
    # the specified article, sorted by date
    # Note: the list will include the original article
    def similar(article)
      @sorted = article.tags.map do |tag|
        [
          app.blog(:episodes).tags.fetch(tag, []),
          app.blog(:blog).tags.fetch(tag, [])
        ]
      end.flatten.uniq.sort_by { |e|
        e.data.date
      }
    end

    private

    def indexes(count)
      (-1...count).to_a - [0]
    end

  end
end
