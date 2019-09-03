class Person < ApplicationRecord
    validates :firstName, presence: true, length: { maximum: 15, minimum: 3 }
    validates :lastName, presence: true, length: { maximum: 15, minimum: 3 }
    validates :firstName, uniqueness: { scope: [:firstName, :lastName, :birthday], message: "This person already exists!" }
    has_many :photostars
    has_many :photos, through: :photostars
    has_many :albumstars
    has_many :albums, through: :albumstars
    
    def unique_person
        "#{lastName},#{firstName}  - #{birthday}"
    end
end
