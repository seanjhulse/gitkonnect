class RemovePostAndCommentsFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :votes, :post, foreign_key: true
    remove_reference :votes, :comment, foreign_key: true
  end
end
