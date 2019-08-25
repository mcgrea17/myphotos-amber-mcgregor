class AlterLocationDropcolumnLocationId < ActiveRecord::Migration[5.2]
  def change
    remove_column  :locations, :location_id 
  end
end
