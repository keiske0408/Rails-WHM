FactoryBot.define do
  factory :withdrawal_request do
    wr_number { "MyString" }
    user { nil }
    business_unit { nil }
    goods_receipt { nil }
    request_date { "2025-08-29" }
    required_date { "2025-08-29" }
    status { 1 }
    priority { 1 }
    purpose { "MyText" }
    notes { "MyText" }
  end
end
