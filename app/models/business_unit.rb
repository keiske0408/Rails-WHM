class BusinessUnit < ApplicationRecord
  has_paper_trail
  
  has_many :users
  has_many :withdrawal_requests
  has_many :goods_issuances

  validates :name, :code, presence: true
  validates :code, uniqueness: true

  scope :active, -> { where(active: true) }

  def self.for_select
    active.pluck(:name, :id)
  end
end
