class PhotosController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @photos = Photo.all
        @photos = Photo.search(params[:term], params[:page])
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo =Photo.create(photo_params)
        if @photo.valid?
          redirect_to root_path
        else
          render :new, status: :unprocessable_entity
        end
      end
    
      private
    
      def photo_params
        params.require(:photo).permit(:location, :caption, :picture, :date)
      end
end
