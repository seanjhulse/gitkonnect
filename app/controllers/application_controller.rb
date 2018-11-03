class ApplicationController < ActionController::Base

  def restricted
    if current_user.nil?
      redirect_to '/403'
    end
  end

  def fourothree
    render 'layouts/403.html', layout: false
  end
end
