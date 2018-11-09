class RemoveVotesFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :upvotes, :integer
    remove_column :posts, :downvotes, :integer
  end
end
