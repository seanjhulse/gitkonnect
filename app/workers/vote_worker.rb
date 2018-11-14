class VoteWorker
  include Sidekiq::Worker

  def perform(*args)
    # Update the rankings of each post
    Post.all.each do |post|
      post.update_attributes(rank: post.hot)
    end
    # Update the rankings of each comment
    Comment.all.each do |comment|
      comment.update_attributes(rank: comment.hot)
    end
  end
end
