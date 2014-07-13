class PhotosController < ApplicationController
  before_action :set_photo

  helper_method :current_page, :total_pages

  def index
  end

  def search
    render partial: 'list'
  end

  private

  def set_photo
    @photos, @info = Flickr::Searcher.
      search(search_params).slice(:photos, :info).values
  end

  def search_params
    (params[:search] || {}).merge page: current_page
  end

  def current_page
    [[searched_page, 1].max, total_pages].min
  end

  def searched_page
    (params[:search].try(:[], :page) || 1).to_i
  end

  def total_pages
    @info.try(:[], 'pages') || Float::INFINITY
  end
end
