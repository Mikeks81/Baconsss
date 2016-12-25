require 'twilio-ruby'

module Twilio_api
    @@account_sid = ENV['TWILIO_SID']
    @@auth_token = ENV['TWILIO_AUTH_TOKEN']
    @@twilio_phone = ENV['TWILIO_PHONE']

    def start_messages
        puts '@@@@@@@@ STARTING NOTIFICATIONS @@@@@@@@@'
        user = self
        # message_info saves to message model as a log
        to = user.phones.first.phone_number
        body = 'Starting notifications'
        transmission = 'outgoing'
        message_info = Twilio_api.populate_message_info(to, body, transmission, user)

        message_is_sent = Twilio_api.send_message(message_info['to'], message_info['body'], user)

        message_is_sent = true

        if message_is_sent
            puts '@@@@@@@@ SENT 1ST, LOGGING TO DB @@@@@@@@@'
            Message.create(message_info)
            user.update_attributes(active: true)
            settings = Twilio_api.get_active_profile_settings(user)
            Twilio_api.start_interval(user, settings)
        end
    end

    def self.send_message(to, message_body, user)
        if user.is_active?
            begin
                puts '@@@@@@@@ SENDING NOTIFICATION @@@@@@@@@'
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

    def self.populate_message_info(to, body, transmission, user)
        puts '@@@@@@@@ CREATING MSG INFO @@@@@@@@@'
        message_info = {}
        message_info['to'] = to
        message_info['from'] = @@twilio_phone
        message_info['body'] = body
        message_info['transmission'] = transmission
        message_info['user_id'] = user.id
        message_info
    end

    def self.start_interval(user, _settings)
        puts '@@@@@@@@ STARTING INTERVAL @@@@@@@@@'
        interval = settings['text_user_interval']
        respond_in_time = settings["response_time"]
        # interval = Twilio_api.hours_to_seconds(0.15)

        ## current issues, timer is off or logic to trigger message is off.. but usually takes about 30mins to send off message
        ## -- thinking about using a field in user table to count how many messages are sent while user is active. if count = 0 then send starting message (require user to respond in order to start messaging.) if 1 then send repond in an hour message
        puts "@@@@@@@@ WHILE LOOP #{interval} @@@@@@@@@"
        Thread.new do
            puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
            while user.is_active?
                sleep interval
                # sleep Twilio_api.hours_to_seconds(interval)
                time_now = Time.new

                last_outgoing = user.last_outgoing_message
                last_outgoing = last_outgoing.created_at unless last_outgoing.nil?

                outgoing_diff = Twilio_api.dt_diff(time_now, last_outgoing, 'h')

                last_response = user.last_incoming_message
                last_response = last_response.created_at unless last_response.nil?

                incoming_diff = Twilio_api.dt_diff(time_now, last_response, 'h')

                next unless outgoing_diff >= interval && incoming_diff >= interval
                puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$'
                puts 'sending contacts a message'
                Twilio_api.send_msg_to_user_contacts(user)
                break
            end
        end
    end

    def self.hours_to_seconds(hr)
        (hr * 60).to_i
    end

    def self.dt_diff(time_1, time_2, format)
        # sec = "s", min = "m", hours = "h", days = "d"
        diff = time_1.to_i - time_2.to_i
        (diff / 60) / 60 if format == 'h'
    end

    def self.process_response(params)
        to = @@twilio_phone
        # gsub removes all non numberic characters
        from = params['From'].gsub!(/\D/, '')
        body = params['Body']
        transmission = 'incoming'

        user = Phone.where(phone_number: from, contact_id: nil).first.user

        set_user = user.id
        message = Twilio_api.populate_message_info(to, from, body, transmission, user)
        Messsage.create(message)

        settings = Twilio_api.get_active_profile_settings(user)
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
                puts "@@@@@@@@@@@@ SENDING CONTACTS #{to} @@@@@@@@@"
                # senidng message and checking is successful. if successful then log that message into db.
                message_is_sent = Twilio_api.send_message(to, body,user)
                if message_is_sent
                    message = Twilio_api.populate_message_info(to, body, transmission, user)
                    Message.create(message)
                end
            end
        end
    end
end
