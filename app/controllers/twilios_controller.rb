class TwiliosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:user_text_response]
  include Twilio_api
  require 'twilio-ruby'

  def create
    if !user.active
      user.update_attributes(active: true)
      user.start_messages
      redirect_to root_path
    else
      user.update_attributes(active: false)
      #user.stop_messages -- create this message
      redirect_to root_path
    end
  end

  def update
  end

  def destroy
  end

  def user_text_response
    puts params.inspect
    Twilio_api.process_response(params)

    redirect_to root_path
  end

  helper_method :user
  def user
    @user ||= current_user
  end
end
