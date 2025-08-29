FactoryBot.define do
  factory :goods_issuance do
    gi_number { "MyString" }
    withdrawal_request { nil }
    user { nil }
    issue_date { "2025-08-29" }
    status { 1 }
    notes { "MyText" }
    sap_document_number { "MyString" }
    sap_posted_at { "2025-08-29 07:05:35" }
    sap_response { "MyText" }
  end
end
