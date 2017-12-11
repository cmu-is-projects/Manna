require 'twilio-ruby'

# to determine whether to use the test credentials
# or the real credentials
$real = true

module TwilioConnection
  def send_sms(to_number, message, real)
    if real
      # real credentials
      # account_sid = Rails.application.secrets.twilio_sid
      # auth_token = Rails.application.secrets.twilio_auth_token
      # from_number = Rails.application.secrets.twilio_number
      account_sid = SETTINGS[:twilio_sid]
      auth_token = SETTINGS[:twilio_auth_token]
      from_number = SETTINGS[:twilio_number]
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

  def send_submitted_sms(manna_case)
    recipients = User.head_deacons.to_a + User.financial_deacons.to_a
    recipients.each do |recipient| 
      message = "Hello, #{recipient.first_name}. A new case has been submitted for review. Click here to view: http://localhost:3000/cases/#{manna_case.id.to_s}"
      to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
      send_sms(to_phone_num, message, $real)
    end
  end

  def send_approved_sms(manna_case)
    recipients = User.staffs.to_a 
    recipients.push(manna_case.deacon)
    recipients.each do |recipient|
      message = "Hello, #{recipient.first_name}. The case '#{manna_case.subject}' has been approved. Click here to view: http://localhost:3000/cases/#{manna_case.id.to_s}" 
      to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
      send_sms(to_phone_num, message, $real)
    end
  end 

  def send_rejected_sms(manna_case)
    recipient = manna_case.deacon
    message = "Hello, #{recipient.first_name}. Your case '#{manna_case.subject}' has been rejected. Click here to view: http://localhost:3000/cases/#{manna_case.id.to_s}"
    to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
    send_sms(to_phone_num, message, $real)
  end 

  def send_processed_sms(manna_case)
    # A check for case.subject has been processed and is awaiting your signature.
    recipients = User.head_deacons.to_a
    recipients.each do |recipient| 
      message = "Hello, #{recipient.first_name}. A check for the case '#{manna_case.subject}' has been processed and is awaiting your signature. Click here for details: http://localhost:3000/cases/#{manna_case.id.to_s}"
      to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
      send_sms(to_phone_num, message, $real)
    end
  end

  def send_signed_sms(manna_case)
    # The check for your case case.subject for case.client_name has been signed.
    recipients = User.head_deacons.to_a
    recipients.push(manna_case.deacon)
    recipients.each do |recipient| 
      message = "Hello, #{recipient.first_name}. A check for the case '#{manna_case.subject}' has been signed. Click here for details: http://localhost:3000/cases/#{manna_case.id.to_s}"
      to_phone_num = recipient.phone.length > 10 ? "+#{recipient.phone}" : "+1#{recipient.phone}"
      send_sms(to_phone_num, message, $real)
    end
  end

end
