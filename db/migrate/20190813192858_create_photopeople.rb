class CreatePhotopeople < ActiveRecord::Migration[5.2]
  def change
    create_table :photopeople do |t|
      t.integer :people_id
      t.integer :photo_id
      t.timestamps
    end
  end
end
