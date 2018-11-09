class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :restricted
  before_action :set_vote
  
  def upvote
    if @vote.nil?
      return
    end

    # if the vote has already been upvoted, undo that action
    if @vote.vote == 1
      @vote.vote = 0
    else
      @vote.vote = 1
    end

    @vote.save!
  end

  def downvote
    if @vote.nil?
      return
    end

    # if the vote has already been downvoted, undo that action
    if @vote.vote == -1
      @vote.vote = 0
    else
      @vote.vote = -1
    end

    @vote.save!
  end

  private

  def set_vote
    # don't let them set a vote for posts that don't exist
    begin
      if params.has_key? :post_id
        Post.find(params[:post_id])
        @vote = Vote.where(voters_type: 'Post', voters_id: params[:post_id], user_id: current_user.id).first_or_initialize
      elsif params.has_key? :comment_id
        Comment.find(params[:comment_id])
        @vote = Vote.where(voters_type: 'Comment', voters_id: params[:comment_id], user_id: current_user.id).first_or_initialize
      else
        throw ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound => e
      @vote = nil # extra insurance that nothing will be done
      render 'does_not_exist.js.erb'
      return
    end
  end

end