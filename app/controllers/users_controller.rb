class UsersController < ApplicationController

  def index
  end

  def show
    @contact = user.contacts.build
    @contacts = user.contacts
    @contact_phone = @contact.phones.build
    @user_phone = user.phones.build
    @user_profile = user.profiles.build
    @profile_contact_joins = @user_profile.profile_contact_joins.build
  end

  def edit
    @user_phone = user.phones.empty? ? user.phones.build : user.phones
  end

  def update
    if user.update_attributes(user_params)
      flash[:notice] = "User Sucessfully Updated"
      redirect_to root_path
    else
      flash[:notice] = user.errors.full_messages.first
      redirect_to user_path user
    end
  end

  def destroy
    if user.destroy
      flash[:notice] = "User Successfully Updated"
      redirect_to root_path
    end
  end

  private
  helper_method :user
  def user
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phones_attributes => [:id, :phone_type, :phone_number])
  end
end
