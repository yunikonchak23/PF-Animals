class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :image_id
      t.string :pet_name
      t.string :type_name
      t.integer :gender, default: 0

      t.timestamps
    end
  end
end
