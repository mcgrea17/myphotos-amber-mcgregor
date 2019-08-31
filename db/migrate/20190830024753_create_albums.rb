class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :location_id
      t.date :startDate 
      t.date :endDate
      t.timestamps
    end
  end
end
