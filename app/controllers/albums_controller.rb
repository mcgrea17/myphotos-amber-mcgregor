class AlbumsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create,  :show ]
    skip_before_action :verify_authenticity_token, :only => [:update, :create ]
   

    def index
        @albums = Album.all
        
    end

    def new
        @album = Album.new
        @album.albumstars.build
    end

    def create
        @album = current_user.albums.create(album_params)
    
        if @album.valid?
          redirect_to album_path(@album.id)
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
      @album = Album.find(params[:id])
      @location_id = params[:location_id]
     
       @photos = Photo.where('location_id = ?  and date >= ? and date <= ?', 
             @album.location_id, @album.startDate, @album.endDate)
           
    end

    def edit
      @album = Album.find(params[:id])
      if @album.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end
    end


    
    private
    
      def album_params
      
        params.require(:album).permit(:location_id, :startDate, :name, :endDate, person_ids: [] )

      end

end
