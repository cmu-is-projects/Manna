module Contexts
  module paymentContexts
    def create_payments
      @payment_one = FactoryGirl.create(:payment, \
        case: @case_gordon
        payable_to: "John Locke", \
        description: "Need to pay backrent for a year",\
        amount: "500", \
        payment_type: "Rent")
      # @payment_review = FactoryGirl.create(:payment, client_name: "Jonathan Tsao", date_submitted: 2.days.ago.to_date, summary: "Lorem ipsum", status: "submitted", subject: "Medical Bill", deacon: @jason)
      # @payment_review1 = FactoryGirl.create(:payment, client_name: "Evan Li", date_submitted: 2.days.ago.to_date, summary: "Lorem ipsum", status: "submitted", subject: "Car repair", deacon: @larry)
      # @payment_approved = FactoryGirl.create(:payment, client_name: "Thomas Lu", date_submitted: 2.weeks.ago.to_date, summary: "Lorem ipsum", status: "approved", subject: "Need money for food", deacon: @larry)
      # @payment_rejected = FactoryGirl.create(:payment, client_name: "Spencer Poon", date_submitted: 3.months.ago.to_date, summary: "Lorem ipsum", status: "rejected", subject: "Lost job", deacon: @jon)
      # @payment_check_signed = FactoryGirl.create(:payment, client_name: "Molly Chou", date_submitted: 3.weeks.ago.to_date, summary: "Lorem ipsum", status: "check_signed", subject: "Need money for surgery", deacon: @jon)
      # @payment_check_processed = FactoryGirl.create(:payment, client_name: "Catherine Zeng", date_submitted: 13.months.ago.to_date, summary: "Lorem ipsum", status: "check_processed", subject: "Eviction", deacon: @jon)
    end

    def remove_payments
      @payment_one.destroy
      # @payment_review.destroy
      # @payment_review1.destroy
      # @payment_approved.destroy
      # @payment_rejected.destroy
      # @payment_check_signed.destroy
      # @payment_check_processed.destroy
    end

  end
end
