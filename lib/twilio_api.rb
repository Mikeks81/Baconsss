require 'twilio-ruby'
require 'time_conversion'

module Twilio_api
    @@account_sid = ENV['TWILIO_SID']
    @@auth_token = ENV['TWILIO_AUTH_TOKEN']
    @@twilio_phone = ENV['TWILIO_PHONE']

    def start_messages
        puts '@@@@@@@@ STARTING NOTIFICATIONS @@@@@@@@@'
        user = self
        # message_info saves to message model as a log
        to = user.phones.first.phone_number
        from = @@twilio_phone
        body = 'Starting notifications'
        transmission = 'outgoing'
        message_info = Twilio_api.populate_message_info(to,from, body, transmission, user)

        # message_is_sent = Twilio_api.send_message(message_info['to'], message_info['body'], user)

        if message_is_sent
            puts '@@@@@@@@ SENT 1ST, LOGGING TO DB @@@@@@@@@'
            Message.create(message_info)
            settings = Twilio_api.get_active_profile_settings(user)
            # Twilio_api.start_interval(user, settings)
        end
    end

    def self.send_message(to, message_body, user)
        if user.is_active?
            begin
                puts '@@@@@@@@ SENDING NOTIFICATION @@@@@@@@@'
                puts user.is_active?
                @client = Twilio::REST::Client.new @@account_sid, @@auth_token
                @client.account.messages.create(from: @@twilio_phone,
                                                to: to,
                                                body: message_body)
                return true
            rescue Twilio::REST::RequestError => e
                puts e.message
                return false
            end
        end
    end

    def self.populate_message_info(to,from, body, transmission, user)
        puts '@@@@@@@@ CREATING MSG INFO @@@@@@@@@'
        message_info = {}
        message_info['to'] = to
        message_info['from'] = from
        message_info['body'] = body
        message_info['transmission'] = transmission
        message_info['user_id'] = user.id
        message_info
    end

    def self.start_interval(user, settings)
        interval = settings['text_user_interval']
        interval_in_seconds = TimeConversion.hours_to_seconds(interval)
        respond_in_time = settings['response_time']
        respond_in_time_secs = TimeConversion.hours_to_seconds(respond_in_time)

        puts "@@@@@@@@ NEW THREAD LOOP #{interval} hours @@@@@@@@@"
        Thread.new do
            initial_text = true
            while user.is_active?
                sleep interval_in_seconds
                if !initial_text
                    to = user.phones.first.phone_number
                    from = @@twilio_phone
                    body = "Are you ok? Respond in #{respond_in_time} hour(s)."
                    transmission = 'outgoing'
                    message_info = Twilio_api.populate_message_info(to,from, body, transmission, user)

                    message_is_sent = Twilio_api.send_message(to, body, user)

                    Message.create(message_info) if message_is_sent
                    initial_text = false

                    sleep respond_in_time_secs
                    time_now = Time.new

                    # time of last response from the user to app twilio phone number
                    last_response = user.last_incoming_message
                    last_response = last_response.created_at unless last_response.nil?

                    # change this back to hours ("h") when ready for production
                    incoming_diff = TimeConversion.dt_diff(time_now, last_response, 's')
                    puts "respond_in_time = #{respond_in_time}"
                    puts "incoming_diff = #{incoming_diff}"
                    if incoming_diff >= respond_in_time_secs
                        Twilio_api.send_msg_to_user_contacts(user)
                        break
                    else
                        interval = settings['text_user_interval'] - settings['response_time']
                    end
                else
                    initial_text = false
                end
            end
            puts 'end of while loop !!!!!!!!!!!!!!!!!!!'
        end
    end

    def self.process_response(params)
        to = @@twilio_phone
        # gsub removes all non numberic characters
        from = params['From'].gsub!(/\D/, '')
        body = params['Body']
        transmission = 'incoming'

        user = Phone.where(phone_number: from, contact_id: nil).first.user

        set_user = user.id
        message = Twilio_api.populate_message_info(to,from, body, transmission, user)
        Message.create(message)
    end

    def self.get_active_profile_settings(user)
        puts '@@@@@@@@@@ GETTING PROFILE SETTINGS @@@@@@@@@'
        # gets profile params and user.contacts into hash
        settings = {}
        profile = user.profiles.where(active: true).first
        contacts = profile.contacts

        settings['text_user_interval'] = profile.text_user_interval
        settings['response_time'] = profile.response_time

        settings['contacts_phone'] = contacts.collect { |c| c.phones.first.phone_number }

        settings
    end

    def self.send_msg_to_user_contacts(user)
        puts '@@@@@@@@@@@@ SENDING CONTACTS METHOD @@@@@@@@@'
        if user.is_active?
            body = "Alert from Beacon. #{user.first_name} #{user.last_name} has been non responsive and asked that you are alerted that #{user.first_name} could be in trouble."

            transmission = 'alert'

            settings = Twilio_api.get_active_profile_settings(user)
            settings['contacts_phone'].each do |phone_number|
                to = phone_number
                from = @@twilio_phone
                puts "@@@@@@@@@@@@ SENDING CONTACTS #{to} @@@@@@@@@"
                # senidng message and checking is successful. if successful then log that message into db.
                message_is_sent = Twilio_api.send_message(to, body, user)
                if message_is_sent
                    message = Twilio_api.populate_message_info(to,from, body, transmission, user)
                    Message.create(message)
                end
            end
        end
    end
end
