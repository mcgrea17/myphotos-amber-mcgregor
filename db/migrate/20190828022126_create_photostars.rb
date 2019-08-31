class CreatePhotostars < ActiveRecord::Migration[5.2]
  def change
    create_table :photostars do |t|
      t.references :person, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true

      t.timestamps
    end
  end
end
