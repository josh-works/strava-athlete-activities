class Athlete < ApplicationRecord
  has_many :activities
  belongs_to :token
end
