class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :question_title
      t.text :question_body
      t.boolean :is_active,null: false, default: false

      t.timestamps
    end
  end
end
