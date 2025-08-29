FactoryBot.define do
  factory :inventory_level do
    item { nil }
    warehouse_location { "MyString" }
    batch_lot { "MyString" }
    total_quantity { "9.99" }
    available_quantity { "9.99" }
    reserved_quantity { "9.99" }
    reorder_level { "9.99" }
    maximum_level { "9.99" }
    unit_cost { "9.99" }
    average_monthly_usage { "9.99" }
    last_receipt_date { "2025-08-29" }
    last_issue_date { "2025-08-29" }
    last_updated { "2025-08-29 07:13:42" }
  end
end
