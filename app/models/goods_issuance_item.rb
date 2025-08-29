class GoodsIssuanceItem < ApplicationRecord
  has_paper_trail
  
  belongs_to :goods_issuance
  belongs_to :withdrawal_request_item

  validates :issued_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :issued_quantity_within_limits

  delegate :item, to: :withdrawal_request_item

  after_save :update_inventory_levels

  def requested_quantity
    withdrawal_request_item.requested_quantity
  end

  def remaining_quantity
    requested_quantity - issued_quantity
  end

  private

  def issued_quantity_within_limits
    return unless withdrawal_request_item && issued_quantity

    if issued_quantity > withdrawal_request_item.requested_quantity
      errors.add(:issued_quantity, "cannot exceed requested quantity")
    end
  end

  def update_inventory_levels
    return unless issued_quantity_changed?

    goods_receipt_item = withdrawal_request_item.goods_receipt_item
    inventory_level = InventoryLevel.find_by(
      item: goods_receipt_item.item,
      warehouse_location: goods_receipt_item.warehouse_location,
      batch_lot: goods_receipt_item.batch_lot
    )

    if inventory_level
      quantity_change = issued_quantity - (issued_quantity_was || 0)
      inventory_level.available_quantity -= quantity_change
      inventory_level.reserved_quantity += quantity_change
      inventory_level.save!
    end
  end
end
