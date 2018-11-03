class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to :back
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :repo, :user_id)
  end

  def set_post
    @post = Post.find(params[:id]).where(user_id: current_user.id)
  end
end
