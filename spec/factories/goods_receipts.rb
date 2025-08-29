FactoryBot.define do
  factory :goods_receipt do
    gr_number { "MyString" }
    po_reference { "MyString" }
    receipt_date { "2025-08-29" }
    user { nil }
    status { 1 }
    notes { "MyText" }
    quality_approved { false }
    quality_notes { "MyString" }
    sap_document_number { "MyString" }
    sap_posted_at { "2025-08-29 06:36:06" }
    sap_response { "MyText" }
  end
end
