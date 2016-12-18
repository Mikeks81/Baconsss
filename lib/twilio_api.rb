require 'twilio-ruby'

module Twilio_api
  @@account_sid = ENV["TWILIO_SID"]
  @@auth_token = ENV["TWILIO_AUTH_TOKEN"]
  @@twilio_phone = ENV["TWILIO_PHONE"]

  def start_messages
    # set up a client to talk to the Twilio REST API
    # begin
    @client = Twilio::REST::Client.new @@account_sid, @@auth_token
    @client.account.messages.create({
        :from => @@twilio_phone,
        :to => self.phones.first.phone_number,
        :body => "Checking on your status.You have an hour",
        # US phone numbers can make use of an image as well
     # media_url: image_url
    })
    # rescue Twilio::REST::RequestError => e
    #   puts e.message
    # end
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
      sender_phone = params["From"].gsub!(/\D/,"")
      sender_message = params["Body"]

      #user look up
      user = Phone.where(phone_number: sender_phone, contact_id: nil).first.user

      puts "@@@@@@@@@@@@@@@@@@@@ USER @@@@@@@@@@@@@@@@@@@@@@@"
      puts user.inspect
      puts sender_phone
      puts sender_message

      user_profile = user.profiles.where(active: true).first
      #time is in hours
      send_message_interval = user_profile.text_user_interval
      #time in hours - if user doesn't respond in this many hours then send a message to contacts
      msg_contact_non_responsive = user_profile.response_time
  end

  def send_msg_to_user_contacts(user)
    if user.active?
      to = user.phones.first.phone_number
      body = "Alert from Beacon. #{user.first_name} #{user.last_name} has been non responsive and asked that you are alerted that #{user.first_name} could be in trouble."

      user.profiles.first.contacts.each do |contact|
        Twilio_api.send_message(to, body)
      end
    end
  end

end
