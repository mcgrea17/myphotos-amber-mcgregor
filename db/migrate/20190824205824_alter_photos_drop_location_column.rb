class AlterPhotosDropLocationColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :location
    add_index :locations, :location_id
  end
end
