class PeopleController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    

    def new
        # @people = Person.all(:order => "lastName, firstName, birthday")
        @people = Person.all.order(lastName: :asc, firstName: :asc , birthday: :desc)
        @person = Person.new
    end

    def create
        @person =Person.create(people_params)
        if @person.valid?
            redirect_to new_person_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
        def people_params
            params.require(:person).permit(:firstName, :lastName, :birthday)
        end
end
