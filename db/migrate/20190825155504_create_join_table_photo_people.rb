class CreateJoinTablePhotoPeople < ActiveRecord::Migration[5.2]
  def change
    create_join_table :photos, :people do |t|
      # t.index [:photo_id, :person_id]
      # t.index [:person_id, :photo_id]
    end
  end
end
