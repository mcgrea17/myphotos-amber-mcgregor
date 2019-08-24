class Location < ApplicationRecord
    has_many :photos
    validates :name, presence: true, length: { maximum: 35, minimum: 3 }, uniqueness: { scope: [:name, :address], message: "This location already exists!" }
    
    def unique_location
        "* #{name}, #{address}"
    end
end
