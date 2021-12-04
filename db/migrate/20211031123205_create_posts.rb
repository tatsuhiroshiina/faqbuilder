class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :question
      t.text :answer
      t.string :type
      t.integer :question_id
      t.timestamps
    end
  end
end
