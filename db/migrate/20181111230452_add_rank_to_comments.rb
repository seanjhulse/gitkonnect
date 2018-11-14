class AddRankToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rank, :decimal, precision: 8, scale: 2
  end
end
