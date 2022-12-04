FactoryBot.define do
  factory :address do
    municipe { nil }
    zipcode { "MyString" }
    street { "MyString" }
    complement { "MyString" }
    neighborhood { "MyString" }
    city { "MyString" }
    uf { "MyString" }
    ibge_code { "MyString" }
  end
end
