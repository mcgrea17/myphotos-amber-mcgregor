class ChangeLocationName < ActiveRecord::Migration[5.2]
  def change
    rename_column :photos, :locationAddress, :location
  end
end
