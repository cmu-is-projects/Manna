class Payment < ActiveRecord::Base

    belongs_to :case


    $PAYMENT_TYPES = %w[utilities rent medical vehicle_repair other]

    #validations
    validates_presence_of :case_id
    validates_inclusion_of :payment_type, in: $PAYMENT_TYPES, message: "is not an option"

    
    
end
