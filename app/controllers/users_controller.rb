class UsersController < ApplicationController
  before_action :restricted

  def profile
    @posts = Post.where(user_id: current_user.id)
  end
end