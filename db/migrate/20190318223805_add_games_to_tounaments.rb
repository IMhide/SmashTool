class AddGamesToTounaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :games, :string, array: true
    add_index :tournaments, :games, using: :gin
  end
end
