class DropPhotoPeople < ActiveRecord::Migration[5.2]
  def change
    drop_table :photo_people
    drop_table :photopeople
    
  end
end
