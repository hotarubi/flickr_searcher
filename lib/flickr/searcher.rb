module Flickr
  class Searcher
    PER_PAGE = 21
    DATE_FORMAT = /^\d{4}-\d{2}-\d{2}$/
    SORT_FORMAT = /^(date-posted-asc|date-posted-desc|interestingness-desc|relevance)$/

    class << self

      def search(params = {})
        response_list = flickr.photos.search(sanitize(params))
        return [] unless response_list.present?
        photos = response_list.map do |resp|
          { square: FlickRaw.url_q(resp), large: FlickRaw.url_b(resp) }
        end
        { info: response_list.instance_variable_get(:@h).except('photo'), photos: photos}
      end

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
          per_page: PER_PAGE
        }
      end
    end

  end
end
