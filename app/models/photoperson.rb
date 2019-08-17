class Photoperson < ApplicationRecord
    belongs_to :photo 
    belongs_to :person 
end
