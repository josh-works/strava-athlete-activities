class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.integer :strava_id
      t.string :name
      t.float :distance
      t.string :moving_time
      t.integer :elapsed_time
      t.float :total_elevation_gain
      t.float :elev_high
      t.float :elev_low
      t.float :average_speed
      t.float :max_speed
      t.datetime :start_date

      t.timestamps
    end
  end
end

def initialize(opts = {})
  @argument = opts[:argument]
  @argument = opts[:argument]
  @argument = opts[:argument]
  @argument = opts[:argument]
end