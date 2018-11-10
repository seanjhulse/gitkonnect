class CommentsController < ApplicationController
  before_action :set_comment, except: [:create, :new]
  before_action :check_owner, except: [:create, :new, :update, :destroy]

  def create
    if current_user.nil?
      render 'error.js.erb'
      return
    end

    # create comment
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    # find post for the view
    @post = Post.find(@comment.post_id)
    
    respond_to do |format|
      if @comment.save
        format.json { render json: {"Success": "Comment created."} }
        format.js   { render 'create.js.erb' }
      else
        format.json { render json: {"Error": "Comment could not be created"} }
        format.js   { render 'error.js.erb' }
      end
    end
  end

  def new
    @post = Post.find(params[:post_id])
    if params.has_key?(:id)
      @parent = Comment.find(params[:id])
    end
    @comment = Comment.new
  end

  def edit
    if @comment.parent
      @parent = Comment.find(@comment.parent)
    end
    @post = Post.find(@comment.post_id)
  end

  def update
    @post = Post.find(@comment.post_id)
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.js   { render 'update.js.erb' }
      else
        format.js   { render 'error.js.erb' }
      end
    end
  end

  def destroy
    @comment.comment = "<i>Deleted</i><br/>"

    respond_to do |format|
      if @comment.save!
        format.json { render json: {"Success": "Saved the comment."} }
      else
        format.json { render json: {"Error": "Failed to save the comment."} }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :parent_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_owner
    if @comment.user_id != current_user.id
      respond_to do |format| 
        format.json { flash[:notice] = 'You are not the owner of this comment.' }
      end
    end
  end

end