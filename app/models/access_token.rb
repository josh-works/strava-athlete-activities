require "json"
require "uri"
require "net/http"

class AccessToken
  CLIENT_ID="63764"
  CLIENT_SECRET="2e6c5168e3b97a9c0975e5377041b8a416b4fbf8"
  URL = "https://www.strava.com/oauth/token?"
  
  
  def self.get_tokens_by_code(code = "")
    url = URI("https://www.strava.com/oauth/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&code=#{code}&grant_type=authorization_code")
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Post.new(url)
    response = https.request(request)
    JSON.parse(response)
  end
end


