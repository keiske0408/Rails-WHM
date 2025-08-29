class Approval < ApplicationRecord
  has_paper_trail
  
  belongs_to :withdrawal_request
  belongs_to :user

  validates :status, :approval_date, presence: true

  enum status: { approved: 1, rejected: 0 }

  scope :recent, -> { order(approval_date: :desc) }

  after_create :update_withdrawal_request_status

  private

  def update_withdrawal_request_status
    withdrawal_request.update!(status: self.status)
  end
end
