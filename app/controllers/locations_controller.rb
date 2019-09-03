class LocationsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def show
        @locations = Location.all
    end

    def new
        @locations = Location.all
        @location = Location.new
    end

    def create
        @location = Location.create(location_params)
        if @location.valid?
            redirect_to new_location_path
          else
            render :new, status: :unprocessable_entity
          end
    end

    def destroy
        @location = Location.find(params[:id])
        if @location.user != current_user
          return render plain: 'Not Allowed', status: :forbidden
        end
    
        @location.destroy
        redirect_to user_photos_path(current_user)
    end
      
    private
        def location_params
            params.require(:location).permit(:name, :address, :id)
        end
        
    
end
