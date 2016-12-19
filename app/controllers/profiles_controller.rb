class ProfilesController < ApplicationController

	def create
		if profile.update_attributes(profile_params)
			flash[:notice] = "Successfully created a profile"
			redirect_to user_path user
		else
			flash[:alert] = profile.errors.full_messages.first
			redirect_to user_path user
		end
	end

	def edit
		@profile_contact_joins = profile.profile_contact_joins
	end

	def update
		Profile.replace_active(user) if params[:profile][:active]
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
		params.require(:profile).permit(:name, :text_user_interval, :response_time,:text_contact_time, :active,
						:profile_contact_joins_attributes => [:id, :contact_id, :profile_id])
	end

end
