class PhotosController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create,  :photos_by_user ]
    skip_before_action :verify_authenticity_token, :only => [:update, :create ]

    def index
        @photos = Photo.all
        @photos = Photo.search(params[:term], params[:page])
    end

    def new
        @photo = Photo.new
        @photo.photostars.build
    end

    def create
      
        @photo = current_user.photos.create(photo_params)

        if @photo.valid?
         
          redirect_to user_photos_path(current_user)
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
      @photos = Photo.where(user_id: current_user)
      @photos = Photo.where(user_id: current_user).search(params[:term], params[:page])
    end

    def edit
      @photo = Photo.find(params[:id])
      if @photo.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end
    end

    def update
      @photo = Photo.find(params[:id])
      if @photo.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end
  
      @photo.update_attributes(photo_params)
      if @photo.valid?
        redirect_to user_photos_path(current_user)
      else
        render :edit, status: :unprocessable_entity
      end
      
    end

    def destroy
      @photo = Photo.find(params[:id])
      if @photo.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end

      @photo.destroy
      
      redirect_to user_photos_path(current_user)
    end
    

    
    private
    
      def photo_params
       
        params.require(:photo).permit(:location_id, :caption, :picture, :date,
          :user_id, person_ids: [])
    end

end
