class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @post = Post.find(@comment.post_id)
  end

  def destroy
    @comment.comment = "<i>Deleted</i><br/>"
    @comment.save
  end

  def reply
    @post = Post.find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :parent_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end