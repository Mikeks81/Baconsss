class ProfilesController < ApplicationController

	def create
		if profile.update_attributes(profile_params)
			flash[:notice] = "Successfully created a profile"
			redirect_to user_path user
		end
	end

	def update
		if profile.update_attributes(profile_params)
			flash[:notice] = "Successfully updated profile"
			redirect_to user_path user
		end
	end

	def destroy
		if profile.destroy
			flash[:notice] = "Successfully deleted profile"
			redirect_to user_path user
		end
	end

	private

	helper_method :user
	def user
		@user ||= current_user
	end

	helper_method :profile
	def profile
		@profile ||= Profile.where(id: params[:id]).first || user.profiles.build
	end

	def profile_params
		params.require(:profile).permit(:text_user_interval, :response_time,:text_contact_time, :active)
	end

end
