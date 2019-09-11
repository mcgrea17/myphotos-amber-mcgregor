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
      if (@album.people.present?)
       
          scope = Photo.joins(:photostars)
          scope = scope.where([ "person_id IN (#{@album.people.ids.join(', ')})" ]).distinct
        
      else 
        scope = Photo
      end

      if (@album.location.name != "Any Location")
        puts "here"
        scope = scope.where([ 'location_id = ?', "#{@album.location_id}" ])
      end

      if (@album.startDate.present? || @album.endDate.present?)
        if (@album.startDate.present? && @album.endDate.present?)
            scope = scope.where([ ' date >= ? and date <= ?', "#{@album.startDate}", "#{@album.endDate}" ])
        else
            if (@album.startDate.present?)
                scope = scope.where([ ' date = ', "#{@album.startDate}" ])
            else
                scope = scope.where([ ' date = ', "#{@album.endDate}" ])
            end
        end
     end

     
    # @photos = ActiveRecord::Base.connection.execute(scope)
    @photos = scope.all   
    #  @photos.photostars.joins(albums: 
    #   { albumstars: Albumstars.where(album_id: @album.id, person_id: person_ids)} )
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
