FactoryBot.define do
  factory :business_unit do
    name { "MyString" }
    code { "MyString" }
    description { "MyText" }
    active { false }
    manager_email { "MyString" }
    contact_person { "MyString" }
    phone_number { "MyString" }
  end
end
