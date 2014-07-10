class PhotosController < ApplicationController
  before_action :set_photo

  def index
  end

  def search
    render partial: 'list'
  end

  private

  def set_photo
    @photos = Flickr::Searcher.search search_params
  end

  def search_params
    params[:search] || {}
  end
end
