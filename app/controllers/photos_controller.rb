class PhotosController < ApplicationController
  before_action :set_photo

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
    params[:search] || { page: 1 }
  end
end
