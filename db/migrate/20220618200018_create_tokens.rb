class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.references :athlete, null: false, foreign_key: true
      t.string :token_type
      t.string :access_token
      t.integer :expires_in
      t.integer :expires_at
      t.string :refresh_token

      t.timestamps
    end
  end
end
