class InventoryLevel < ApplicationRecord
  has_paper_trail
  
  belongs_to :item

  validates :total_quantity, :available_quantity, :reserved_quantity, 
            presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_id, uniqueness: { scope: [:warehouse_location, :batch_lot] }

  scope :by_location, ->(location) { where(warehouse_location: location) }
  scope :low_stock, -> { where('available_quantity <= reorder_level') }
  scope :out_of_stock, -> { where(available_quantity: 0) }

  def issued_quantity
    total_quantity - available_quantity - reserved_quantity
  end

  def turnover_ratio
    return 0 unless average_monthly_usage.positive?
    
    available_quantity.to_f / average_monthly_usage
  end

  def stock_status
    return 'Out of Stock' if available_quantity.zero?
    return 'Low Stock' if available_quantity <= reorder_level
    'Normal'
  end

  def location_batch_key
    "#{warehouse_location}-#{batch_lot}".presence || 'N/A'
  end
end
