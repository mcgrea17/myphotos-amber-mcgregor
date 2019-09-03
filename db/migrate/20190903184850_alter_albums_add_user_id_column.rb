class AlterAlbumsAddUserIdColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :user_id, :integer
    add_index :albums, :user_id

  end
end
