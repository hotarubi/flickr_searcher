module Flickr
  class Searcher

    class << self
      def search(params)

      end

      private
      def default_query
        { text: '',
          min_upload_date: 1.month.ago.to_date.to_s,
          max_upload_date: Date.today.to_s,
          sort: 'interestingness-desc'
        }
      end
    end

  end
end
