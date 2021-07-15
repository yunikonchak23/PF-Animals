class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :pet_id
      t.string :diary_image_id
      t.string :diary_title
      t.text :diary_body

      t.timestamps
    end
  end
end
