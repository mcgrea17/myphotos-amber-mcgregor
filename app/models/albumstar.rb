class Albumstar < ApplicationRecord
    belongs_to :person
    belongs_to :album
    has_one :person
    has_one :album
end
