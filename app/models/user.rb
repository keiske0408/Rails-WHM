class User < ApplicationRecord
has_paper_trail
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => Rails.application.credentials.otp_secret_key

  belongs_to :business_unit, optional: true
  has_many :goods_receipts, dependent: :destroy
  has_many :withdrawal_requests, dependent: :destroy
  has_many :approvals, dependent: :destroy
  has_many :goods_issuances, dependent: :destroy

  enum role: { 
    requestor: 0, 
    bu_head: 1, 
    warehouse_manager: 2,
    admin: 3 
  }

  validates :first_name, :last_name, :role, presence: true
  validates :employee_id, presence: true, uniqueness: true

  before_validation :set_default_role, on: :create

  scope :active, -> { where(active: true) }
  scope :by_role, ->(role) { where(role: role) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_access_goods_receipt?
    warehouse_manager? || admin?
  end

  def can_access_goods_issuance?
    warehouse_manager? || admin?
  end

  def can_approve_requests?
    bu_head? || warehouse_manager? || admin?
  end

  def can_view_all_reports?
    warehouse_manager? || admin?
  end

  def otp_qr_code
    issuer = 'WMS'
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer))
    qrcode.as_svg(module_size: 4)
  end

  private

  def set_default_role
    self.role ||= :requestor
  end
end
