class Comment < ApplicationRecord
  EPOCH = DateTime.new(1970, 1, 1)
  
  belongs_to :post
  belongs_to :user
  
  # VALIDATIONS
  validates :comment, :user_id, :post_id, :presence => true

  # ASSOCIATIONS
  has_many :votes, as: :voters, dependent: :destroy
  has_one :parent, :foreign_key => :parent_id

  # SCOPES
  scope :hot,    -> { sort_by(&:hot) }           # hottest posts
  scope :newest, -> { order(created_at: :desc) } # most recent posts

  # returns the children comments
  def children 
    Comment.where(parent_id: self.id)
  end

  def parent
    self.parent_id
  end

  def posted_by
    return "Posted by #{User.find(self.user_id).username} on #{self.created_at.strftime('%A %d %b %Y')}"
  end

  def epoch_seconds
    t = DateTime.now
    (t.to_i - EPOCH.to_i).to_f
  end

  def hot
    p self.votes
    score = votes.sum {|vote| vote[:vote] }
    displacement = Math.log( [score.abs, 1].max,  10 )

    sign = if score > 0
      1
    elsif score < 0
      -1
    else
      0
    end

    return (displacement * sign.to_f) + ( epoch_seconds / 45000 )
  end 
end
