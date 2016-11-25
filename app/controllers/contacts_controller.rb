class ContactsController < ApplicationController
  def create
  	if contact.update_attributes!(contact_params)
  		flash[:notice] = "Contact successfully created"
  		redirect_to user_path current_user
  	end
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
  	@contact ||= Contact.where(id: params[:id]).first || user.contacts.build
  end
  helper_method :phones
  def phones
  	@phones ||= contact.phones.build
  end
  def contact_params
  	params.require(:contact).permit(:first_name, :last_name, :email, :nickname, :email, :relationship,
  	  			:phones_attributes => [:id, :phone_type, :phone_number])
  end
end
