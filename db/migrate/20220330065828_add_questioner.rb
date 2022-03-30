class AddQuestioner < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :questioner, :string
  end
end
