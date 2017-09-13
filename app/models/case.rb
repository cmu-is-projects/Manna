include TwilioConnection
include PgSearch
class Case < ActiveRecord::Base
  belongs_to :deacon, class_name: "User", foreign_key: "deacon_id"
  before_create :set_date
  after_create :send_submitted_sms
  after_update :send_update_sms

  $STATUSES = %w[submitted approved rejected check_signed check_processed]

  has_many :votes
  has_many :case_attachments
  has_many :attachments, through: :case_attachments

  validates_presence_of :client_name, :summary, :subject
  validates_inclusion_of :status, in: $STATUSES, message: "is not an option"
  accepts_nested_attributes_for :attachments, reject_if: lambda { |attachment| attachment[:name].blank? }, allow_destroy: true


  #scopes
  scope :chronological,       -> { order('date_submitted DESC') }
  scope :client_alphabetical, -> { order(:client_name)}

  scope :submitted,           -> { where(status: "submitted")}
  scope :approved,            -> { where(status: "approved")}
  scope :rejected,            -> { where(status: "rejected")}
  scope :check_processed,     -> { where(status: "check_processed")}
  scope :check_signed,        -> { where(status: "check_signed")}

  scope :for_deacon,          -> (user_id) {where(deacon_id: user_id) }
  scope :for_client,          -> (client_name) {where("client_name LIKE ?", client_name + "%")}
  scope :by_client_name,      -> { order("client_name ASC") }

  scope :voted_by_deacon,     -> (user_id) {joins(:votes).where('votes.deacon_id = ?', user_id)}
 
  pg_search_scope :search, against: [:client_first_name, :client_name], :using => {
                dmetaphone: {},
                trigram: {}
              }
  

  def self.not_voted_by_deacon(user)
    cases = Case.submitted - Case.submitted.voted_by_deacon(user.id)
    cases.sort_by!{|c| c.date_submitted}.reverse unless cases.empty?
  end

  #methods
  def set_date
    self.date_submitted = Date.current
  end

  def status_display
    if self.status == "check_signed"
      return "check signed"
    elsif self.status == "check_processed"
      return "check processed"
    else
      return self.status
    end
  end

  # def self.search(search)
  #   where("client_name LIKE ? OR summary LIKE ? OR subject LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  # end

  def has_voted?(user)#takes all the votes in that particular case, and see if the current user's id
    self.votes.map(&:deacon_id).include?(user.id)
  end

  private
  def send_submitted_sms
    TwilioConnection::send_submitted_sms(self)
  end

  def send_update_sms
    if self.status == 'approved'
      TwilioConnection::send_approved_sms(self)
    elsif self.status == 'rejected'
      TwilioConnection::send_rejected_sms(self)
    elsif self.status == 'check_processed'
      TwilioConnection::send_processed_sms(self)
    elsif self.status == 'check_signed'
      TwilioConnection::send_signed_sms(self)
    end
  end

end
