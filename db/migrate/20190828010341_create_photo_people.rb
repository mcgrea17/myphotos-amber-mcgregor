class CreatePhotoPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_people do |t|
      t.references :photo, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true

      t.timestamps
    end
  end
end
