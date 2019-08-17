class AddUniqueIndexPerson < ActiveRecord::Migration[5.2]
  def change
    add_index :people, [:firstName, :lastName, :birthday], :unique => true
  end
end
