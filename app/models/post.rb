class Post < ApplicationRecord
  belongs_to :user
  has_many :votes
  validates :title, :description, :repo, :presence => true

  EPOCH = DateTime.new(1970, 1, 1)

  def posted_by
    return "Posted by #{User.find(self.user_id).username} on #{self.created_at.strftime('%A %d %b %Y')}"
  end

  def epoch_seconds
    t = DateTime.now
    (t.to_i - EPOCH.to_i).to_f
  end

  def hot
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
