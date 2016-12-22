require 'twilio-ruby'

module Twilio_api
  @@account_sid = ENV["TWILIO_SID"]
  @@auth_token = ENV["TWILIO_AUTH_TOKEN"]
  @@twilio_phone = ENV["TWILIO_PHONE"]

  def start_messages
    # set up a client to talk to the Twilio REST API
    # begin
    user = self

    @client = Twilio::REST::Client.new @@account_sid, @@auth_token
    @client.account.messages.create({
        :from => @@twilio_phone,
        :to => self.phones.first.phone_number,
        :body => "Starting notifications",
        # US phone numbers can make use of an image as well
     # media_url: image_url
    })
    # rescue Twilio::REST::RequestError => e
    #   puts e.message
    # end

    settings = Twilio_api.get_active_profile_settings(user)
  end

  def send_message(to,message_body)
    @client = Twilio::REST::Client.new @@account_sid, @@auth_token
    @client.account.messages.create({
        :from => @@twilio_phone,
        :to => to,
        :body => message_body
        # US phone numbers can make use of an image as well
     # media_url: image_url
    })
  end

  def self.process_response(params)
    #gsub removes all non numberic characters
    sender_phone = params["From"].gsub!(/\D/,"")
    sender_message = params["Body"]

    #user look up
    user = Phone.where(phone_number: sender_phone, contact_id: nil).first.user

    puts "@@@@@@@@@@@@@@@@@@@@ #{user} @@@@@@@@@@@@@@@@@@@@@@@"
    puts user.inspect
    puts sender_phone
    puts sender_message

    settings = Twilio_api.get_active_profile_settings(user)
  end

  def self.get_active_profile_settings(user)

    settings = {}
    profile = user.profiles.where(active: true).first
    contacts = profile.contacts

    settings["text_user_interval"] = profile.text_user_interval
    settings["response_time"] = profile.response_time

    settings["contacts_phone"] = contacts.collect {|c| c.phones.first.phone_number}

    settings
  end

  def send_msg_to_user_contacts(user,settings)
    if user.active?
      to = user.phones.first.phone_number
      body = "Alert from Beacon. #{user.first_name} #{user.last_name} has been non responsive and asked that you are alerted that #{user.first_name} could be in trouble."

      settings["contacts_phone"].each do |contact|
        Twilio_api.send_message(to, body)
      end
    end
  end

end
