class User < ActiveRecord::Base
  before_save :reformat_phone
  has_secure_password

  has_many :votes, through: :cases
  has_many :cases, class_name: "Case", foreign_key: "deacon_id"

  validates_presence_of :first_name, :last_name, :role, :email
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  # validates_inclusion_of :role, in: %w[admin deacon care_connector], message: "is not an option"
  validates_inclusion_of :role, in: %w[admin care\ deacon financial\ deacon head\ deacon staff], message: "is not an option"
  validates_uniqueness_of :email, allow_blank: true
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  #scopes
  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where(active: false) }
  scope :deacons,         -> { where.not(role: 'staff') }
  scope :care_deacons,        -> { where(role: 'care deacon') }
  scope :financial_deacons,   -> { where(role: 'financial deacon') }
  scope :staffs,      -> { where(role: 'staff') }
  scope :head_deacons, -> { where(role: 'head deacon')}
  scope :alphabetical,    -> { order('last_name, first_name') }


  #show cases by user

  #methods
  def name
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  def role?(authorized_role)
    return false if self.nil?
    self.role.to_sym == authorized_role
  end

  def self.authenticate(email,password)
    find_by_email(email).try(:authenticate, password)
  end

  private
  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end

end
