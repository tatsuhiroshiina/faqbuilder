class AddQuestionTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :question_type, :string
  end
end
