class AlbumsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create,  :photos_by_user ]
    skip_before_action :verify_authenticity_token, :only => [:update, :create ]

    def index
        @albums = Album.all
    end

    def new
        @album = Album.new
    end

    def create

        @album = Album.create(album_params)
       
      puts "HELLO THERE"
      puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      
     puts album_params
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        # if :person_ids?
        #   params[:person_ids].each do |i|
        #     Photostar.create(person_id: i[:id], photo_id: @photo.id)
        #   end
        # end

        if @album.valid?
         
          redirect_to album_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show
      @album = Album.find(params[:id])
      puts "###################"
    #   @photos = @album.joins.photos.where('date >= ? and date <=  ? and location_id = ? ', 
    #         @album.startDate, @album.endDate, @album.location_id)
    #         # "%#{[:startDate]}%", "%#{album_params[:endDate]}%", "%#{album_params[:location_id]}%")
        
    end

    def edit
      @album = Album.find(params[:id])
      if @album.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end
    end


    
    private
    
      def album_params
      
        params.require(:album).permit(:location_id, :startDate, :name, :endDate)
        # Add [] to person_ids[] and they will be passed but then get parameter missing given 0 expeting 1..2
        
      end

end
