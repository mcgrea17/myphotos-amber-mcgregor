class Location < ApplicationRecord
    has_many :photos,  :foreign_key => :location_id
    validates :name, presence: true, length: { maximum: 35, minimum: 3 }, uniqueness: { scope: [:name, :address], message: "This location already exists!" }
    
    def unique_location
        "* #{name}, #{address}"
    end
end
