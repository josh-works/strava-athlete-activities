class Activity < ApplicationRecord
  has_many :polylines
  def initialize(opts = {})
    require "pry"; binding.pry
    
    @argument = opts[:argument]
    @argument = opts[:argument]
    @argument = opts[:argument]
  end
end
