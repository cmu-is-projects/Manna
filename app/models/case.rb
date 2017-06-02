class Case < ActiveRecord::Base
  belongs_to :deacon, class_name: "User", foreign_key: "deacon_id"
  before_create :set_date

  has_many :votes
  has_many :case_documents
  has_many :documents, through: :case_documents

  validates_presence_of :client_name, :summary, :subject
  validates_inclusion_of :status, in: %w[submitted review\ in\ progress approved rejected check\ signed check\ processed], message: "is not an option"
  accepts_nested_attributes_for :documents, reject_if: lambda { |document| document[:name].blank? }, allow_destroy: true


  #scopes
  scope :chronological,    -> { order('date_submitted DESC') }
  scope :submitted,        -> { where(status: "submitted")}
  scope :reviewed, -> {where("status != ?", "submitted")}
  scope :review_in_progress,        -> { where(status: "review in progress")}
  scope :approved,        -> { where(status: "approved")}
  scope :rejected,        -> { where(status: "rejected")}
  scope :check_signed,        -> { where(status: "check signed")}
  scope :check_processed,        -> { where(status: "check processed")}
  scope :for_deacon,       -> (user_id) {where(deacon_id: user_id) }
  scope :for_client,      -> (client_name) {where("client_name LIKE ?", client_name + "%")}
  scope :by_client_name,         -> { order("client_name ASC") }
  # scope case voted by deacon
  # scope case not voted by deacon

  #methods
  def set_date
    self.date_submitted = Date.current
  end

  def self.search(search)
    where("client_name LIKE ? OR summary LIKE ? OR subject LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def has_voted?(user)#takes all the votes in that particular case, and see if the current user's id
    self.votes.map(&:deacon_id).include?(user.id)
  end

end
