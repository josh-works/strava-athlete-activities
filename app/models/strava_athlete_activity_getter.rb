require 'httparty'
require "uri"
require "net/http"

class StravaAthleteActivityGetter
  PARAMS_TO_KEEP = Activity.column_names.map(&:to_sym)
  
  def self.get_activities
    token = "70bf1be1d6e6ae36c1c64f0f5feae95d76c5ae43"
    

    url = URI("https://www.strava.com/api/v3/activities")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer 70bf1be1d6e6ae36c1c64f0f5feae95d76c5ae43"
    # request["Cookie"] = "_strava4_session=5ohv23b989h79kfj8h72thkq90t6ds8e"

    response = https.request(request)
    data = JSON.parse(response.body)
    
    data.each do |activity_params|
      activity_params.symbolize_keys!
      
      Activity.create(activity_params)
    end

  end
end