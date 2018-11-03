class Post < ApplicationRecord
  belongs_to :user
  validates :title, :description, :repo, :presence => true

  def posted_by
    return "Posted by #{User.find(self.user_id).username} on #{self.created_at.strftime('%A %d %b %Y')}"
  end
end
