class Payment < ActiveRecord::Base

    belongs_to :case


    $PAY_BY = ['Mail', 'Leave at Desk', 'Other']
    # %w[mail leave]

    #validations
    # validates_presence_of :case_id
    validates :payment_type, :presence => true, :uniqueness => false, :allow_blank => true
    validates :pay_by, :presence => true
    validates_inclusion_of :pay_by, in: $PAY_BY, message: "is not an option"
    # validates_inclusion_of :payment_type, in: $PAYMENT_TYPES, message: "is not an option"
    validates_numericality_of :amount, greater_than_or_equal_to: 0


    
  def client_proper_name(caseObj) 
    caseObj.client_first_name + ' ' + caseObj.client_name
  end
    
end
