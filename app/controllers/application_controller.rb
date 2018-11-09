class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def restricted
    if current_user.nil?
      redirect_to '/403'
    end
  end

  def fourothree
    render 'layouts/403.html', layout: false
  end
end
