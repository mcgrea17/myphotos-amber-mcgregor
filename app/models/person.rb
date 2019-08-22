class Person < ApplicationRecord
    has_many :photopersons
    validates :firstName, presence: true, length: { maximum: 15, minimum: 3 }
    validates :lastName, presence: true, length: { maximum: 15, minimum: 3 }
    validates :firstName, uniqueness: { scope: [:firstName, :lastName, :birthday], message: "This person already exists!" }
  
    def unique_person
        "#{lastName},#{firstName}  - #{birthday}"
    end
end
