class Album < ApplicationRecord
    validates :name, presence: true
    belongs_to :location
    belongs_to :user
    has_many :photostars
    has_many :people, through: :photostars
end
