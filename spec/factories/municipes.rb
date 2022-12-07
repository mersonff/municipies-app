# frozen_string_literal: true

FactoryBot.define do
  factory :municipe do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    cns { '200055910360003' }
    email { Faker::Internet.email }
    birth_date { Faker::Date.birthday(min_age: 1, max_age: 110) }
    phone { '+55 (88) 99778-7269' }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/municipe.jpg'), 'image/jpeg') }
    status { :active }
    address { build(:address) }
  end
end
