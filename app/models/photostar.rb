class Photostar < ApplicationRecord
  belongs_to :person, inverse_of: :photostars
  belongs_to :photo, inverse_of: :photostars
  
end
