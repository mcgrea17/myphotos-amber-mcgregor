class Albumstar < ApplicationRecord
    belongs_to :person, inverse_of: :albumstars
    belongs_to :album, inverse_of: :albumstars
    has_many :photos, through: :photostars
    has_many :photostars
end
