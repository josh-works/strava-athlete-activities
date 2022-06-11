require "test_helper"

class StravaAthleteActivityGetterTest < ActiveSupport::TestCase
  test "::get_activities gets a page of activities and creates new Activies" do
    VCR.use_cassette("activities") do
      result = StravaAthleteActivityGetter.get_activities
      assert result
      # require "pry"; binding.pry
      require "pry"; binding.pry
      assert_equal 32, Activity.count
    end
  end
end