class CaseAttachment < ActiveRecord::Base
  belongs_to :attachment
  belongs_to :case


end
