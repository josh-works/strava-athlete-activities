require "test_helper"

class StravaAthleteActivityGetterTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true
  def setup
    
  end
  
  test "::get_activities gets a page of activities and creates new Activies" do
    VCR.use_cassette("activities") do
      assert Activity.count < 5
      assert Polyline.count < 5
      
      StravaAthleteActivityGetter.get_activities
      
      assert Activity.count > 30
      assert Polyline.count > 30
    end
  end
end