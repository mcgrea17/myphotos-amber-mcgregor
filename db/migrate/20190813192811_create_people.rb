class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :firstName
      t.string :lastName
      t.date :birthday
      t.timestamps
    end
  end
end
