class GoodsReceiptItem < ApplicationRecord
  has_paper_trail
  
  belongs_to :goods_receipt
  belongs_to :item

  validates :quantity, :unit_price, presence: true
  validates :quantity, :unit_price, :available_quantity, numericality: { greater_than: 0 }
  validates :item_id, uniqueness: { scope: :goods_receipt_id }

  before_save :update_inventory_level

  def total_value
    quantity * unit_price
  end

  private

  def update_inventory_level
    return unless goods_receipt.completed?

    inventory_level = InventoryLevel.find_or_initialize_by(
      item: item,
      warehouse_location: warehouse_location,
      batch_lot: batch_lot
    )

    if inventory_level.persisted?
      inventory_level.available_quantity += available_quantity
      inventory_level.total_quantity += quantity
    else
      inventory_level.assign_attributes(
        available_quantity: available_quantity,
        total_quantity: quantity,
        unit_cost: unit_price,
        last_receipt_date: goods_receipt.receipt_date
      )
    end

    inventory_level.save!
  end
end
