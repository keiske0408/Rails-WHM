class WithdrawalRequestItem < ApplicationRecord
  has_paper_trail
  
  belongs_to :withdrawal_request
  belongs_to :goods_receipt_item

  validates :requested_quantity, presence: true, numericality: { greater_than: 0 }
  validate :quantity_available

  delegate :item, to: :goods_receipt_item

  def sufficient_stock?
    requested_quantity <= goods_receipt_item.available_quantity
  end

  def item_description
    item.description
  end

  def item_code
    item.item_code
  end

  private

  def quantity_available
    return unless goods_receipt_item && requested_quantity

    available = goods_receipt_item.available_quantity
    if requested_quantity > available
      errors.add(:requested_quantity, "exceeds available quantity (#{available})")
    end
  end
end
