class PhotosController < ApplicationController
  before_action :set_photo, only: [:show]

  def index
    @photos = []
  end

  def show
  end

  private

  def set_photo
    @photo = nil# Photo.find(params[:id])
  end

  def photo_params
    params[:photo]
  end
end
