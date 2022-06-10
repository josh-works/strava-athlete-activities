require "test_helper"

class StravaAthleteActivityGetterTest < ActiveSupport::TestCase
  test "::get_activities gets a page of activities and creates new Activies" do
    VCR.use_cassette("activities") do
      # assert_equal 0, Activity.all.count
      
      result = StravaAthleteActivityGetter.get_activities
      assert result
      require "pry"; binding.pry
      assert_greater_than 50, result.count
    end
  end
end