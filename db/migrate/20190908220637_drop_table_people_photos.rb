class DropTablePeoplePhotos < ActiveRecord::Migration[5.2]
  def change
    drop_table :people_photos
  end
end
