class GoodsReceipt < ApplicationRecord
  has_paper_trail
  
  belongs_to :user
  has_many :goods_receipt_items, dependent: :destroy
  
  accepts_nested_attributes_for :goods_receipt_items, allow_destroy: true

  validates :po_reference, :receipt_date, presence: true
  validates :gr_number, presence: true, uniqueness: true

  enum status: { 
    draft: 0, 
    quality_check: 1, 
    completed: 2, 
    cancelled: 3 
  }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_po, ->(po) { where("po_reference ILIKE ?", "%#{po}%") }
  
  before_validation :generate_gr_number, on: :create

  def total_quantity
    goods_receipt_items.sum(:quantity)
  end

  def can_submit_to_sap?
    quality_check? && goods_receipt_items.any?
  end

  private

  def generate_gr_number
    return if gr_number.present?
    
    date_part = Date.current.strftime("%Y%m%d")
    sequence = GoodsReceipt.where("gr_number LIKE ?", "GR#{date_part}%").count + 1
    self.gr_number = "GR#{date_part}#{sequence.to_s.rjust(4, '0')}"
  end
end
