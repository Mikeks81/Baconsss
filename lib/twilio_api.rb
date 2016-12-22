require 'twilio-ruby'

module Twilio_api
  @@account_sid = ENV["TWILIO_SID"]
  @@auth_token = ENV["TWILIO_AUTH_TOKEN"]
  @@twilio_phone = ENV["TWILIO_PHONE"]

  def start_messages
    user = self
    # message_info saves to message model as a log
    to = user.phones.first.phone_number
    body = "Starting notifications"
    transmission = "outgoing"
    message_info = Twilio_api.populate_message_info(to, body, message_info)

    message_is_sent = Twilio_api.send_message(message_info["to"], message_info["body"])

    if message_is_sent
      Message.create(message_info)
      user.update_attributes(active: true)
    end

    settings = Twilio_api.get_active_profile_settings(user)
    Twilio_api.start_interval(user, settings)
  end

  def self.send_message(to,message_body)
    begin
      @client = Twilio::REST::Client.new @@account_sid, @@auth_token
      @client.account.messages.create({
          :from => @@twilio_phone,
          :to => to,
          :body => message_body
      })
      return true
    rescue Twilio::REST::RequestError => e
      puts e.message
      return false
    end
  end

  def self.populate_message_info(to,body,transmission)
    message_info = {}
    message_info["to"] = to
    message_info["from"] = @@twilio_phone
    message_info["body"] = body
    message_info["transmission"] = transmission
    message_info["user_id"] = user.id
    message_info
  end

  def self.start_interval(user,settings)
    interval = settings["text_user_interval"]
    send_next_message = start_time + interval.hour

    last_outgoing = user.messages.where(transmission: "outgoing").order("created_at ASC").first
    last_response = user.messages.where(transmission: "incoming").order("created_at ASC").first

    loop do
      sleep 60 / (settings["text_user_interval"] * 60)
      time_now = DateTime.new
      if (time_now.to_i - last_outgoing.created_at.to_i) / 60 >= (interval * 60)
        #send message
      end
    end
    # start timer
    # if user has not responded to text withing the text user interval specified by user then send to msgs to contacts

    # if has_responded is false then continue timeer if true reset timer... if timer is up send message.
    # if response == false
    #   sleep
    # else
    #
    # end
  end

  def self.process_response(params)
    #gsub removes all non numberic characters
    sender_phone = params["From"].gsub!(/\D/,"")
    sender_message = params["Body"]

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

  def self.send_msg_to_user_contacts(user,settings)
    if user.active?
      to = user.phones.first.phone_number
      body = "Alert from Beacon. #{user.first_name} #{user.last_name} has been non responsive and asked that you are alerted that #{user.first_name} could be in trouble."

      transmission = "alert - outgoing to contact"

      settings["contacts_phone"].each do |contact|
        message_is_sent = Twilio_api.send_message(to, body)
        if message_is_sent
          message = Twilio_api.populate_message_info(to,body, transmission)
          Message.create(message)
        end
      end
    end
  end

end
