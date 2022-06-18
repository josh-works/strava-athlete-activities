class Athlete < ApplicationRecord
  has_many :activities
  has_one :token
end
