require 'httparty'
require "uri"
require "net/http"

class StravaAthleteActivityGetter
  # PARAMS_TO_KEEP = Activity.column_names.map(&:to_sym)
  TOKEN = "dac5003dd04d7b760352365060d95b7c3aae92a1"
  
  def self.get_activities
    athelete = Athlete.last
    url = URI("https://www.strava.com/api/v3/activities")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{TOKEN}"

    response = https.request(request)
    data = JSON.parse(response.body)
    data.each do |row|
      p row
      activity = Activity.create(
        athlete: athelete,
        name: row["name"],
        strava_id: row["id"],
        distance: row["distance"],
        moving_time: row["moving_time"],
        elapsed_time: row["elapsed_time"],
        total_elevation_gain: row["total_elevation_gain"],
        elev_high: row["elev_high"],
        elev_low: row["elev_low"],
        average_speed: row["average_speed"],
        max_speed: row["max_speed"],
        start_date: row["start_date"],
      )
      
      Polyline.new(activity: activity, polyline: row["map"]["polyline"])
      Rails.logger.info("Created #{activity.id}, #{activity.name}")
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