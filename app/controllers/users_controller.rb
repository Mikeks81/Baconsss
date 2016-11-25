class UsersController < ApplicationController
  def index
  end

  def show
    phones
  end

  def edit
  end

  def update
  end

  def destroy
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

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end

end
