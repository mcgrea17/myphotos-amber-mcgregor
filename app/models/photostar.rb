class Photostar < ApplicationRecord
  belongs_to :person
  belongs_to :photo
  has_one :person
  has_one :photo
end
