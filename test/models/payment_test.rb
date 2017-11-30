require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
    should belong_to(:case)

    should validate_presence_of(:case_id)
    should validate_presence_of(:payable_to)
    should validate_presence_of(:amount)
    should validate_presence_of(:payment_type)

    should allow_value("500").for(:amount)
    should allow_value("60.00").for(:amount)
    should_not allow_value("rejected").for(:status)
    should_not allow_value("-3").for(:status)

    context "Creating a context for payments" do
        setup do
          create_users
          create_cases
          create_votes
          create_case_documents
          create_documents
          create_payments
      end

      teardown do
        remove_payments
        remove_documents
        remove_case_documents
        remove_votes
        remove_cases
        remove_users
    end



end
