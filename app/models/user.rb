class User < ActiveRecord::Base
  before_save :reformat_phone
  has_secure_password

  has_many :votes, through: :cases
  has_many :cases, class_name: "Case", foreign_key: "deacon_id"

  validates_presence_of :first_name, :last_name, :role
  validates_presence_of :email
  # validates_presence_of :password, :password_confirmation, on: :create
  # validates_confirmation_of :password, on: :create, message: "does not match"
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  # validates_inclusion_of :role, in: %w[admin deacon care_connector], message: "is not an option"
  validates_inclusion_of :role, in: %w[admin care_deacon financial_deacon head_deacon staff], message: "is not an option"
  # validates_uniqueness_of :email, allow_blank: true, on: :create
  # validates :email, uniqueness: true, on: :create
  validate :email_is_unique
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format", on: :create

  #scopes
  scope :active,              -> { where(active: true) }
  scope :inactive,            -> { where(active: false) }
  scope :deacons,             -> { where.not(role: 'staff') } #should be where role not admin and staff
  scope :care_deacons,        -> { where(role: 'care_deacon') }
  scope :financial_deacons,   -> { where(role: 'financial_deacon') }
  scope :staffs,              -> { where(role: 'staff') }
  scope :head_deacons,        -> { where(role: 'head_deacon')}
  scope :alphabetical,        -> { order('last_name, first_name') }


  #show cases by user
  # Callbacks
  before_destroy :is_destroyable?
  after_rollback :convert_to_inactive

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

  def role_display
    if self.role == "care_deacon"
      return "care deacon"
    elsif self.role == "financial_deacon" 
      return "financial deacon"
    elsif self.role == "head_deacon"
      return "head deacon"
    else
      return self.role
    end
  end

  def self.authenticate(email,password)
    find_by_email(email).try(:authenticate, password)
  end

  private
  def email_is_unique
    exists = User.find_by_email(self.email)
    return true if exists.nil? || (exists.email == self.email) 
    errors.add(:email, "already exists in the system.")
  end

  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end

  def is_destroyable?

    @destroyable = self.cases.empty?

  end
  
  def convert_to_inactive
    if !@destroyable.nil? && @destroyable == false
      make_inactive
    end
    @destroyable = nil
  end

  def make_inactive
    self.update_attribute(:active, false)
  end

end
