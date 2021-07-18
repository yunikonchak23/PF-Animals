class CreateTagMiddles < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_middles do |t|
      t.integer :diary_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
