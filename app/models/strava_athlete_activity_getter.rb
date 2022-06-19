require 'httparty'
require "uri"
require "net/http"

class StravaAthleteActivityGetter
  # PARAMS_TO_KEEP = Activity.column_names.map(&:to_sym)
  
  def self.token
    p "getting token"
    Token.last.access_token
  end
  
  def self.get_activities
    athlete = Athlete.find(4)
    page_count = 0
    5.times do |int|
      url = URI("https://www.strava.com/api/v3/activities?page=#{int + page_count}")
      p "about to hit #{url}"

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{athlete.token.access_token}"

      response = https.request(request)
      data = JSON.parse(response.body)
      p data
      return if data.empty?
      
      data.each do |row|
        activity = Activity.find_or_create_by(strava_id: row["id"]) do |a|
          a.athlete = athlete,
          a.name = row["name"],
          a.strava_id = row["id"],
          a.distance = row["distance"],
          a.moving_time = row["moving_time"],
          a.elapsed_time = row["elapsed_time"],
          a.total_elevation_gain = row["total_elevation_gain"],
          a.elev_high = row["elev_high"],
          a.elev_low = row["elev_low"],
          a.average_speed = row["average_speed"],
          a.max_speed = row["max_speed"],
          a.start_date = row["start_date"]
        end
        
        Polyline.new(activity: activity, polyline: row["map"]["polyline"])
        Rails.logger.info("Created #{activity.id}, #{activity.name}")
      end
    end

  end
  
  def self.get_polyline_for_activity(strava_activity_id)
    url = URI("https://www.strava.com/api/v3/activities/#{strava_activity_id}?include_all_efforts=true")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{TOKEN}"

    response = https.request(request)
    data = JSON.parse(response.body)
    activity = Activity.find_by(strava_id: strava_activity_id)
    line = Polyline.new(activity: activity, polyline: data["polyline"])
    require "pry"; binding.pry
  end
end