class HomesController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  def index
  end

  private
  helper_method :user

  def user
  	@user ||= User.where(id: params[:id]).first || User.new
  end
end
