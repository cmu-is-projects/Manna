require 'twilio-ruby'

# to determine whether to use the test credentials
# or the real credentials
$real = false

module TwilioConnection
  def send_sms(to_number, message, real)
    if real
      # real credentials
      account_sid = Rails.application.secrets.twilio_sid
      auth_token = Rails.application.secrets.twilio_auth_token
      from_number = Rails.application.secrets.twilio_number
    else    
      # test credentials
      account_sid = Rails.application.secrets.twilio_test_sid
      auth_token = Rails.application.secrets.twilio_test_auth_token
      from_number = "+15005550006"
      # from_number provided by twilio to successfully send a test SMS
    end
    
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.account.messages.create({
      :from => from_number,
      :to => to_number,
      :body => message
    })
  end

  # when check submitted: head deacons, financial deacons
  # when check processed: head deacons
  # when check signed: head deacons, case deacon
  # when check approved: staff, care deacon
  # when check rejected: care deacon

  def send_submitted_sms(case)
    message = "New case has been submitted for review. Click here: http://localhost:3000/cases/" + case.id.to_s
    recipients = User.head_deacons.to_a + User.financial_deacons.to_a
    recipients.each do |recipient| 
      to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
      send_sms(to_phone_num, message, $real)
  end

  def send_approved_sms(case)

  end 

  def send_rejected_sms(case)

  end 

  def send_processed_sms(case)
    # A check for case.title has been processed and is awaiting your signature.

  end

  def send_signed_sms(case)
    # The check for your case case.title for case.client_name has been signed.

  end

  def send_winning_sms(person, item)
    cur_person_first_name = !person.first_name.nil? ? " #{person.first_name}" : ""
    won_item_name = !item.name.nil? ? " the " + item.name : " an item"
    message = "Hey there" + cur_person_first_name + ", you've won" + won_item_name + ". Please report to the desk to pay for your item."
    # I don't know how the numbers are stored, but this will ensure
    # that we get the right format assuming the permutation of the digits
    # is correct
    unformatted_num = person.phone_num.gsub(/\D/, "")
    to_phone_num = unformatted_num.length > 10 ? "+#{unformatted_num}" : "+1#{unformatted_num}"
    # to_phone_num = '+17175421992'
    # want to keep it under 160 characters
    if message.length <= 160 
      won_item_path = Rails.application.secrets.root_url + Rails.application.routes.url_helpers.item_path(item)
      msg_with_link = message + " " + won_item_path
      message = msg_with_link.length <= 160 ? msg_with_link : message
    end
    send_sms(to_phone_num, message, $real)
  end

  def send_end_sms(to_number)
    message = "Hi! The silent auction is ending soon. Get your last-minute bids in!"
    send_sms(to_number, message, $real)
  end

  def send_all_winning_messages
    winning_ps = Participant.has_text_notification.all_winning_participants
    for i in 0..winning_ps.length-1
      cur_person = winning_ps[i]
      items_won = cur_person.items_currently_winning
      for w in 0..items_won.length-1
        item_won = items_won[w]
        send_winning_sms(cur_person, item_won)
      end
    end
  end

  def send_end_auction_message
    all_p = Participant.has_text_notification
    for i in 0..all_p.length-1
      cur_p = all_p[i]
      to_phone_num = cur_p.phone_num
      # to_phone_num = '+17175421992'
      send_end_sms(to_phone_num)
    end
  end

  def send_outbid_notification(item)
    second_highest_bid = Bid.second_highest_bid(item)
    outbid_person = second_highest_bid.nil? ? nil : second_highest_bid.participant
    if (!outbid_person.nil?) and outbid_person.text_opt_in
      cur_person_first_name = !outbid_person.first_name.nil? ? " #{outbid_person.first_name}" : ""
      outbid_item_name = !item.name.nil? ? " the " + item.name : " an item"
      message = "Hey there" + cur_person_first_name + ", you've been outbid on" + outbid_item_name + "."
      # I don't know how the numbers are stored, but this will ensure
      # that we get the right format assuming the permutation of the digits
      # is correct
      unformatted_num = outbid_person.phone_num.gsub(/\D/, "")
      to_phone_num = unformatted_num.length > 10 ? "+#{unformatted_num}" : "+1#{unformatted_num}"
      # to_phone_num = '+17175421992'
      # want to keep it under 160 characters
      if message.length <= 160 
        outbid_item_path = Rails.application.secrets.root_url + Rails.application.routes.url_helpers.item_path(item)
        msg_with_link = message + " Make another bid here! " + outbid_item_path
        message = msg_with_link
        # message = msg_with_link.length <= 160 ? msg_with_link : message
      end
      send_sms(to_phone_num, message, $real)
    end
  end

end










