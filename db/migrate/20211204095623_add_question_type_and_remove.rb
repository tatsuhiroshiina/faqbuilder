class AddQuestionTypeAndRemove < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :question_type, :string
    remove_column :users, :question_type, :string
  end
end
