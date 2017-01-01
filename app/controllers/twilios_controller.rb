class TwiliosController < ApplicationController
    before_action :authenticate_user!, except: [:user_text_response]
    skip_before_action :verify_authenticity_token, only: [:user_text_response]
    include Twilio_api
    require 'twilio-ruby'

    def create
        if !user.active
            user.start_messages
            redirect_to root_path
        else
            user.update_attributes(active: false)
            # user.stop_messages -- create this message
            redirect_to root_path
        end
    end

    def update; end

    def destroy; end

    def user_text_response
        puts params.inspect
        Twilio_api.process_response(params)

        render json: { status: :ok }
    end

    helper_method :user
    def user
        @user ||= current_user
    end
end
