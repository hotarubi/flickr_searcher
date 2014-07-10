module Flickr
  class Searcher
    DATE_FORMAT = /^\d{4}-\d{2}-\d{2}$/
    SORT_FORMAT = /^(date-posted-asc|date-posted-desc|interestingness-desc|relevance)$/

    class << self
      extend Memoist

      def search(params = {})
        response_list = flickr.photos.search(sanitize(params))
        return [] unless response_list.present?
        response_list.map do |resp|
          info = flickr.photos.getInfo photo_id: resp['id']
          { square: FlickRaw.url_q(info), large: FlickRaw.url_b(info) }
        end
      end

      memoize :search

      private
      def sanitize(params)
        %i{min_upload_date max_upload_date}.each do |d|
          params.except!(d) unless params[d] =~ DATE_FORMAT
        end
        params.except!(:sort) unless params[:sort] =~ SORT_FORMAT
        default_query.merge!(params)
      end

      def default_query
        { text: '',
          min_upload_date: 1.month.ago.to_date.to_s,
          max_upload_date: Date.today.to_s,
          sort: 'interestingness-desc',
          per_page: 21
        }
      end
    end

  end
end
