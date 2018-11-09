class AddCommentToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :comment, foreign_key: true
  end
end
