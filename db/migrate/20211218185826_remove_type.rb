class RemoveType < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :type, :string
  end
end
