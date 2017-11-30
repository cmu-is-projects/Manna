class Payment < ActiveRecord::Base

    belongs_to :case


    $PAYMENT_TYPES = %w[utilities rent medical vehicle_repair other]

    #validations
    validates_presence_of :case_id
    validates :payment_type, :presence => false, :uniqueness => false, :allow_blank => true
    # validates_inclusion_of :payment_type, in: $PAYMENT_TYPES, message: "is not an option"
    validates_numericality_of :amount, greater_than_or_equal_to: 0
    
end
