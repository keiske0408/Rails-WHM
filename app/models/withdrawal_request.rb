class WithdrawalRequest < ApplicationRecord
  has_paper_trail
  
  belongs_to :user
  belongs_to :business_unit
  belongs_to :goods_receipt
  has_many :withdrawal_request_items, dependent: :destroy
  has_many :approvals, dependent: :destroy
  has_one :goods_issuance, dependent: :destroy

  accepts_nested_attributes_for :withdrawal_request_items, allow_destroy: true

  validates :request_date, presence: true
  validates :wr_number, presence: true, uniqueness: true

  enum status: { 
    pending: 0, 
    approved: 1, 
    rejected: 2, 
    issued: 3,
    cancelled: 4
  }

  enum priority: {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_business_unit, ->(bu_id) { where(business_unit_id: bu_id) }
  scope :by_status, ->(status) { where(status: status) }
  scope :pending_approval, -> { where(status: :pending) }

  before_validation :generate_wr_number, on: :create
  after_update :send_status_notification, if: :saved_change_to_status?

  def total_quantity
    withdrawal_request_items.sum(:requested_quantity)
  end

  def can_be_approved?
    pending? && withdrawal_request_items.all?(&:sufficient_stock?)
  end

  def approver
    approvals.last&.user
  end

  def approval_notes
    approvals.last&.notes
  end

  private

  def generate_wr_number
    return if wr_number.present?
    
    date_part = Date.current.strftime("%Y%m%d")
    sequence = WithdrawalRequest.where("wr_number LIKE ?", "WR#{date_part}%").count + 1
    self.wr_number = "WR#{date_part}#{sequence.to_s.rjust(4, '0')}"
  end

  def send_status_notification
    NotificationJob.perform_later(self, 'status_changed')
  end
end

