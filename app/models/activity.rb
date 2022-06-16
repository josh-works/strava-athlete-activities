class Activity < ApplicationRecord
  has_one :polyline
  belongs_to :athlete
end
