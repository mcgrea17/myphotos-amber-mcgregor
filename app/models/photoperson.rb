class Photoperson < ApplicationRecord
    belongs_to :photo 
    belongd_to :person 
    has_many :photos 
    has_many :persons
end
