class HomesController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  def index
		@user_phone = user.phones.build
		render layout: "landing_page"
  end

  private

  helper_method :user
  def user
  	@user ||= User.new
  end
end
