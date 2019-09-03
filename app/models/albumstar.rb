class Albumstar < ApplicationRecord
    belongs_to :person, inverse_of: :albumstars
    belongs_to :album, inverse_of: :albumstars
   
end
