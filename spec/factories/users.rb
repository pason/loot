FactoryGirl.define do
  factory :user do
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    address_line_1 { Faker::Address.street_address }
    date_of_birth { Faker::Date.birthday(18, 65) }
  end
end