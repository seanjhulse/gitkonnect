class AddVoteTypeToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :voters_type, :string
    add_column :votes, :voters_id,   :integer
  end
end
