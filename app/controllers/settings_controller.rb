class SettingsController < ApplicationController 
  before_action :restricted

  def update
    @settings = Setting.find(current_user.setting.id)

    @settings.update(settings_params)
  end
  
  private

  def settings_params
    params.require(:setting).permit(:code_theme)
  end
end