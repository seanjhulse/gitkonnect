class Post < ApplicationRecord
  belongs_to :user
  has_many :votes
  validates :title, :description, :repo, :presence => true

  scope :order_by_votes, -> (order) {  joins(:votes).group('posts.id').order(Arel.sql("SUM(votes.vote) #{order}")) }

  def posted_by
    return "Posted by #{User.find(self.user_id).username} on #{self.created_at.strftime('%A %d %b %Y')}"
  end

end
