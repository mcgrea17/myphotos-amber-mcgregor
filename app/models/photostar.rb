class Photostar < ApplicationRecord
  belongs_to :person, inverse_of: :photostars
  belongs_to :photo, inverse_of: :photostars
  has_many :albumstars
  has_many :albums, through: :albumstars
end
