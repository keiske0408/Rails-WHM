class GoodsIssuance < ApplicationRecord
  class GoodsIssuance < ApplicationRecord
  has_paper_trail
  
  belongs_to :withdrawal_request
  belongs_to :user
  has_many :goods_issuance_items, dependent: :destroy

  validates :issue_date, presence: true
  validates :gi_number, presence: true, uniqueness: true

  enum status: { 
    draft: 0, 
    partial: 1, 
    completed: 2, 
    cancelled: 3 
  }

  scope :recent, -> { order(created_at: :desc) }
  
  before_validation :generate_gi_number, on: :create
  after_update :update_withdrawal_request_status

  def total_issued_quantity
    goods_issuance_items.sum(:issued_quantity)
  end

  def total_requested_quantity
    withdrawal_request.total_quantity
  end

  def completion_percentage
    return 0 if total_requested_quantity.zero?
    (total_issued_quantity.to_f / total_requested_quantity * 100).round(2)
  end

  private

  def generate_gi_number
    return if gi_number.present?
    
    date_part = Date.current.strftime("%Y%m%d")
    sequence = GoodsIssuance.where("gi_number LIKE ?", "GI#{date_part}%").count + 1
    self.gi_number = "GI#{date_part}#{sequence.to_s.rjust(4, '0')}"
  end

  def update_withdrawal_request_status
    withdrawal_request.update!(status: :issued) if completed?
  end
end

