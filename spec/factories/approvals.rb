FactoryBot.define do
  factory :approval do
    withdrawal_request { nil }
    user { nil }
    status { 1 }
    approval_date { "2025-08-29 07:03:22" }
    notes { "MyText" }
  end
end
