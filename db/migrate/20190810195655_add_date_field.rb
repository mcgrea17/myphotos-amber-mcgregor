class AddDateField < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :date, :date
  end
end
