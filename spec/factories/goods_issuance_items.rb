FactoryBot.define do
  factory :goods_issuance_item do
    goods_issuance { nil }
    withdrawal_request_item { nil }
    issued_quantity { "9.99" }
    notes { "MyText" }
    barcode_scanned { "MyString" }
    scanned_at { "2025-08-29 07:09:32" }
  end
end
