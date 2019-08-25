class AlterPhotoDropcolumnAndAddBelngsTo < ActiveRecord::Migration[5.2]
  def change
    remove_column  :photos, :location_id 
    remove_index :locations
    add_reference :photos, :location, foreign_key: true
    
  end
end
