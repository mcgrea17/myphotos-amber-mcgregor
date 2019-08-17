class Person < ApplicationRecord
    has_many :photopersons
    validates :firstName, presence: true, length: { maximum: 15, minimum: 3 }
    validates :lastName, presence: true, length: { maximum: 15, minimum: 3 }
end
