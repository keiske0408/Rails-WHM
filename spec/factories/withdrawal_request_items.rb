FactoryBot.define do
  factory :withdrawal_request_item do
    withdrawal_request { nil }
    goods_receipt_item { nil }
    requested_quantity { "9.99" }
    notes { "MyText" }
  end
end
