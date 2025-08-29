FactoryBot.define do
  factory :goods_receipt_item do
    goods_receipt { nil }
    item { nil }
    quantity { "9.99" }
    unit_price { "9.99" }
    warehouse_location { "MyString" }
    batch_lot { "MyString" }
    available_quantity { "9.99" }
    remarks { "MyText" }
    quality_passed { false }
    inspection_notes { "MyString" }
  end
end
