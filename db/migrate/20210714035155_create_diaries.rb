class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.integer :pets_id
      t.string :image_id
      t.text :body

      t.timestamps
    end
  end
end
