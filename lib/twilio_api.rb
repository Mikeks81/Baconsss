require 'twilio-ruby'

module Twilio_api
  @@account_sid = ENV["TWILIO_ACCOUNT_SID"]
  @@auth_token = ENV["TWILIO_AUTH_TOKEN"]
  @@twilio_phone = ENV["TWILIO_PHONE"]

  def start_messages
    # set up a client to talk to the Twilio REST API
    # begin
      @client = Twilio::REST::Client.new @@account_sid, @@auth_token
      @client.account.messages.create({
          :from => @@twilio_phone, 
          :to => self.phone.phone_number, 
          :body => "Checking on your status.You have an hour", 
          # US phone numbers can make use of an image as well
       # media_url: image_url
      })
    # rescue Twilio::REST::RequestError => e
    #   puts e.message
    # end
  end
end
