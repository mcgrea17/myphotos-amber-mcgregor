class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :address
      t.integer :location_id
      t.timestamps
    end
  end
end
