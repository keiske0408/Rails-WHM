class Item < ApplicationRecord
  has_paper_trail
  
  has_many :goods_receipt_items
  has_many :withdrawal_request_items
  has_many :goods_issuance_items
  has_many :inventory_levels

  validates :item_code, :description, presence: true
  validates :item_code, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :by_code, ->(code) { where("item_code ILIKE ?", "%#{code}%") }
  scope :by_description, ->(desc) { where("description ILIKE ?", "%#{desc}%") }

  def current_stock_level
    inventory_levels.sum(:available_quantity)
  end

  def reserved_quantity
    inventory_levels.sum(:reserved_quantity)
  end
end
