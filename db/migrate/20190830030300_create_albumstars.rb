class CreateAlbumstars < ActiveRecord::Migration[5.2]
  def change
    create_table :albumstars do |t|
      t.references :person, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true
      t.timestamps
    end
  end
end
