class Attachment < ActiveRecord::Base

  mount_uploader :doc, DocUploader # Tells rails to use this uploader for this model.

  has_many :case_attachments
  has_many :cases, through: :case_attachments

  validates_presence_of :name


end