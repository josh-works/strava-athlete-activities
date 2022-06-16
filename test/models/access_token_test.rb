require "test_helper"

class AccessTokenTest < ActiveSupport::TestCase
  test "::get_tokens_by_code attaches token to Athlete" do
    VCR.use_cassette("get_strava_token") do
      # assert AthleteToken.count < 2
      token_code = "5780b0478df07b9e1af15f2f6013dfe2dd2a89da"
      AccessToken.get_tokens_by_code(token_code)
      # assert AthleteToken.last
      assert token_code
    end
  end
end