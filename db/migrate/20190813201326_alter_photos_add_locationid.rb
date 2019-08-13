class AlterPhotosAddLocationid < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :location_id, :integer
    add_index :photos, :location_id
  end
end
