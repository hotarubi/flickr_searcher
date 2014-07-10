class PhotosController < ApplicationController
  before_action :set_photo

  def index
  end

  def search
    render partial: 'list'
  end

  private

  def set_photo
    @photos = []
  end

  def photo_params
    params[:photo]
  end
end
