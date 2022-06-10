class CreatePolylines < ActiveRecord::Migration[7.0]
  def change
    create_table :polylines do |t|
      t.integer :strava_id
      t.text :polyline
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
