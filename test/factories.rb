FactoryGirl.define do
  factory :user do
    first_name "Jason"
    last_name "Chen"
    email "jason95014@gmail.com"
    password_confirmation "meh"
    password "meh"
    phone "4089315510"
    role "admin"
    active true
  end

  factory :case do
    client_name "Gordon Ramsay"
    date_submitted 2.days.ago.to_date
    summary "Refer to documents"
    status "submitted"
    subject "Paying rent"
    association :care_deacon, factory: :user
  end

  factory :vote do
    association :financial_deacon, factory: :user
    association :case
    decision "yes"
  end

  factory :document do
    name "I9"
  end

  factory :case_document do
    association :case
    association :document
  end

end
