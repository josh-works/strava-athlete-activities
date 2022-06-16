# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

athlete = Athlete.create(
  name: "Josh",
  email: "example@example.com",
  strava_id: "111"
)

activity = athlete.activities.create(
  name: "A to B",
  strava_id: "111",
  distance: 44.5
)
require "pry"; binding.pry
activity.polyline.create(
  polyline: "abc234gasdlkjg"
)