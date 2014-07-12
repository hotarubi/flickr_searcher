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
    @info = { page: 1, pages: 50 }
    @photos = Flickr::Searcher.search search_params
  end

  def search_params
    (params[:search] || {}).merge page: current_page
  end

  def current_page
    [[(params[:search].try(:[], :page) || 1).to_i, 1].max, @info[:pages]].min
  end

  def total_pages
    @info[:pages]
  end
end
