class PhotosController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :show, :edit ]

    def index
        @photos = Photo.all
        @photos = Photo.search(params[:term], params[:page])
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = current_user.photos.create(photo_params)
       
        if @photo.valid?
         
          redirect_to root_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def edit
    end

    
    private
      def people_params
       params.require(:people).permit(people_ids: [])
      end
      def photo_params
        params.require(:photo).permit(:location_id,  :caption, :picture, :date)
      end

end
