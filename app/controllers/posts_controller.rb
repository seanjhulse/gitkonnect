require "open-uri"
require "json"

class PostsController < ApplicationController
  before_action :restricted,   except: [:index, :show]
  before_action :set_my_post,  except: [:index, :new, :create, :show]
  before_action :set_any_post, only:   [:show]

  def index
    @posts = Post.page(params.has_key?(:page) ? params[:page] : 1).hot
  end

  def new
    @post = Post.new
    @repos = get_repos()
  end

  def create
    @post = Post.new(post_params)

    @repo_data = get_repos()
    valid = false
    @repo_data.each do |repo|
      if repo["html_url"] == post_params[:repo]
        valid = true
        break
      end
    end

    unless valid || Rails.env.development
      redirect_back(fallback_location: new_post_path, alert: "Invalid repo. Github doesn't recognize that repo for your account.")
    end

    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_back(fallback_location: new_post_path, alert: @post.errors)
    end
  end

  def edit
    @repos = get_repos()
  end

  def show
    @comment = Comment.new
  end

  def update
    @repo_data = get_repos()
    valid = false
    @repo_data.each do |repo|
      if repo["html_url"] == post_params[:repo]
        valid = true
        break
      end
    end

    unless valid || Rails.env.development
      redirect_back(fallback_location: new_post_path, alert: "Invalid repo. Github doesn't recognize that repo for your account.")
    end

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_back(fallback_location: new_post_path, alert: @post.errors)
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    else
      redirect_back(fallback_location, post_path(@post), alert: @post.errors)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :repo, :user_id)
  end

  def get_repos
    repos_json = open("https://api.github.com/users/#{current_user.username}/repos?per_page=9999&client_id=#{APP_CONFIG[:github][:app_id]}&client_secret=#{APP_CONFIG[:github][:app_secret]}",
      "Accept" => "application/vnd.github.v3+json"
    ).read
    return JSON.parse(repos_json)
  end

  def set_my_post
    @post = Post.where(id: params[:id], user_id: current_user.id).first
  end

  def set_any_post
    @post = Post.find(params[:id])
  end
end
