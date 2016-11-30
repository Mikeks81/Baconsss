class UsersController < ApplicationController
  def index
  end

  def show
    phones
    profile_contact_joins
  end

  def edit
  end

  def update
    if user.update_attributes(user_params)
      flash[:notice] = "User Sucessfully Updated"
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

  helper_method :contact
  def contact
    @contact ||= user.contacts.build
  end

  helper_method :contacts
  def contacts
    @contacts ||= current_user.contacts
  end

  helper_method :phones
  def phones
    @phones ||= contact.phones.build
  end

  helper_method :profile
  def profile
    @profile ||= user.profiles.build
  end

  helper_method :profile_contact_joins
  def profile_contact_joins
    @profile_contact_joins ||= profile.profile_contact_joins.build
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
