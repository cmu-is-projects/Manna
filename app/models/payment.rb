class Payment < ActiveRecord::Base

    belongs_to :case




    #validations
    validates_inclusion_of :role, in: %w[admin care_deacon financial_deacon head_deacon staff], message: "is not an option"
end
