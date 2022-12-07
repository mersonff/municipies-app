# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zipcode { '63960-000' }
    street { Faker::Address.street_name }
    complement { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    uf { Faker::Address.state_abbr }
    ibge_code { '15521' }
  end
end
