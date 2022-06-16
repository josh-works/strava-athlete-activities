class CreateAthletes < ActiveRecord::Migration[7.0]
  def change
    create_table :athletes do |t|
      t.string :name
      t.string :email
      t.integer :strava_id

      t.timestamps
    end
  end
end
