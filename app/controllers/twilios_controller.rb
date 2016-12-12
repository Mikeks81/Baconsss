class TwiliosController < ApplicationController
  include Twilio_api
  require 'twilio-ruby'

  def create
    if !user.active
      user.update_attributes(active: true)
      user.start_messages
    else
      user.update_attributes(active: false)
      #user.stop_messages -- create this message
    end
  end

  def update
  end

  def destroy
  end

  helper_method :user
  def user
    @user ||= current_user
  end
end
