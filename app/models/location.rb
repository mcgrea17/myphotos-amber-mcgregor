class Location < ApplicationRecord
    has_many :photos
    validates :name, presence: true, length: { maximum: 35, minimum: 3 }
end
