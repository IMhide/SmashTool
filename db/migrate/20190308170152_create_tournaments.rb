class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :remote_id, unique: true
      t.string :name
      t.string :slug
      t.string :city
      t.string :region
      t.string :google_place_id
      t.string :address
      t.string :venue_name
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
