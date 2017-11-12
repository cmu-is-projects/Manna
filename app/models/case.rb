include TwilioConnection
include PgSearch
class Case < ActiveRecord::Base

  # @@total_approved = 0

  belongs_to :deacon, class_name: "User", foreign_key: "deacon_id"
  # commenting this out for testing purpose, enable after testing
  before_create :set_date
  after_create :send_submitted_sms
  after_update :send_update_sms

  $STATUSES = %w[submitted approved rejected check_signed check_processed]

  has_many :votes
  has_many :case_attachments
  has_many :attachments, through: :case_attachments

  validates_presence_of :client_name, :summary, :subject, :amount_requested
  validates_inclusion_of :status, in: $STATUSES, message: "is not an option"
  accepts_nested_attributes_for :attachments, reject_if: lambda { |attachment| attachment[:name].blank? }, allow_destroy: true


  #scopes
  scope :chronological,       -> { order('date_submitted DESC') }
  scope :cases_in_month,      -> (mon,yr){where('EXTRACT(MONTH FROM date_submitted) = ? AND EXTRACT(YEAR FROM date_submitted) = ?',mon, yr)}
  # scope :cases_in_month,      -> (mon,yr) { where("(date_submitted + 1.month).month = ? AND (date_submitted + 1.month).year = ?", mon, yr)} 
  scope :client_alphabetical, -> { order(:client_name)}
  scope :earliest_date,       -> { order('date_submitted ASC').limit(1) }
  
  scope :submitted,           -> { where(status: "submitted")}
  scope :approved,            -> { where(status: "approved")}
  scope :rejected,            -> { where(status: "rejected")}
  scope :check_processed,     -> { where(status: "check_processed")}
  scope :check_signed,        -> { where(status: "check_signed")}
  scope :for_deacon,          -> (user_id) {where(deacon_id: user_id) }
  scope :for_client,          -> (client_name) {where("client_name LIKE ?", client_name + "%")}
  scope :by_client_name,      -> { order("client_name ASC") }

  scope :voted_by_deacon,     -> (user_id) {joins(:votes).where('votes.deacon_id = ?', user_id)}
  scope :needs_vote,          -> (user_id) {joins(:votes).where('votes.deacon_id is NULL')}

  # scope :search_query, lambda { |query|
  #   return nil  if query.blank?
  #   # condition query, parse into individual keywords
  #   terms = query.downcase.split(/\s+/)
  #   # replace "*" with "%" for wildcard searches,
  #   # append '%', remove duplicate '%'s
  #   terms = terms.map { |e|
  #     (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  #   }
  #   # configure number of OR conditions for provision
  #   # of interpolation arguments. Adjust this if you
  #   # change the number of OR conditions.
  #   num_or_conditions = 2
  #   where(
  #     terms.map {
  #       or_clauses = [
  #         "LOWER(cases.first_name) LIKE ?",
  #         "LOWER(cases.name) LIKE ?"
  #         # "LOWER(case.email) LIKE ?"
  #       ].join(' OR ')
  #       "(#{ or_clauses })"
  #     }.join(' AND '),
  #     *terms.map { |e| [e] * num_or_conditions }.flatten
  #   )
  # }
  # scope :sorted_by, lambda { |sort_option|
  #   # extract the sort direction from the param value.
  #   direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  #   case sort_option.to_s
  #   when /^created_at_/
  #     order("students.created_at #{ direction }")
  #   when /^name_/
  #     order("LOWER(students.last_name) #{ direction }, LOWER(students.first_name) #{ direction }")
  #   when /^country_name_/
  #     order("LOWER(countries.name) #{ direction }").includes(:country)
  #   else
  #     raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  #   end
  # }
 
  pg_search_scope :search, against: [:client_first_name, :client_name], :using => {
                dmetaphone: {},
                trigram: {}
              }
  
  # filterrific(
  #   # default_filter_params: { sorted_by: 'chronological' },
  #   available_filters: [
  #     # :sorted_by,
  #     :search_query,
  #     :needs_vote
  #   ]
  # )

  # def self.options_for_sorted_by
  #   [
  #     ['Name (a-z)', 'client_alphabetical'],
  #     ['Registration date (newest first)', 'created_at_desc'],
  #     ['Registration date (oldest first)', 'created_at_asc'],
  #     ['Country (a-z)', 'country_name_asc']
  #   ]
  # end



  def self.not_voted_by_deacon(user)
    cases = Case.submitted - Case.submitted.voted_by_deacon(user.id)
    cases.sort_by!{|c| c.date_submitted}.reverse unless cases.empty?
  end

  def self.total_amt_approved()
    total_amt = 0
    cases = Case.approved
    for c in cases do
      total_amt += c.amount_approved
    end
    return total_amt
      
    # cases = Case.submitted - Case.submitted.voted_by_deacon(user.id)
    # cases.sort_by!{|c| c.date_submitted}.reverse unless cases.empty?
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
