class UsersController < ApplicationController
  before_action :restricted

  def profile
    # repos_json = open("https://api.github.com/users/#{current_user.username}/repos?per_page=9999",
    #   "Accept" => "application/vnd.github.v3+json"
    # ).read
    # @repos = JSON.parse(repos_json)
  end
end