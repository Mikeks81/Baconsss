class LocationsController < ApplicationController
  def create
    location = user.locations.build
    if location.update_attributes!(location_params)
      flash[:notice] = "Successfully Updated Location"
    else
      puts "location not updated"
    end
  end

  private
  helper_method :user
  def user
  	@user ||= current_user
  end

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
