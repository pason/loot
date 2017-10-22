FactoryGirl.define do
  factory :transfer do
    account_number_from { Faker::Number.number(18) }
    account_number_to { Faker::Number.number(18) }
    amount_pennies { Faker::Number.between(10, 100) }
    country_code_from { 'GBR' }
    country_code_to { 'GBR' }
    user_id nil
  end
end