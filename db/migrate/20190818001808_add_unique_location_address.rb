class AddUniqueLocationAddress < ActiveRecord::Migration[5.2]
  def change
    add_index :locations, [:name, :address], :unique => true
  end
end
