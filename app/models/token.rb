require "json"
require "uri"
require "net/http"

class Token < ApplicationRecord
  belongs_to :athlete
  
  CLIENT_ID="63764"
  CLIENT_SECRET="2e6c5168e3b97a9c0975e5377041b8a416b4fbf8"
  URL = "https://www.strava.com/oauth/token"
  
  def get_token
    url = URI("https://www.strava.com/oauth/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&code=#{code}&grant_type=authorization_code")
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Post.new(url)
    response = https.request(request)
    data = JSON.parse(response)
    athlete = Athlete.find(4) # obv unserious & a joke
    
    token = Token.new(data)
    token.athlete = athlete
    token.save
    p token
  end
  
  def self.refresh_existing_token
    athlete = Athlete.find(4)
    token = athlete.token
    url = URI("#{URL}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&refresh_token=#{token.refresh_token}&grant_type=refresh_token")
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)

    response = https.request(request).read_body
    formatted = JSON.parse(response)
    p formatted
    p "old token: #{token.access_token}"
    p "new token: #{formatted["access_token"]}"
    if formatted["access_token"] && (formatted["access_token"] != token.access_token)
      token.access_token = formatted["access_token"]
      token.refresh_token = formatted["refresh_token"]
      token.save
    end
  end

  def self.newest_token
    # data = File.read('tokens.json')
    # p data
    # p data.last
    # p JSON.parse(data.last)
    # data.last["refresh_token"]
    # file = File.read('tokens.json')
    # hash = JSON.parse(file)
    # hash.last

    "932469c09ef3da9dbec99a9c8e8364b0f885b021"
  end
end
