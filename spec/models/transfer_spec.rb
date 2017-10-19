require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { should belong_to(:user) }
  
  # Validation test
  it { should validate_presence_of(:account_number_from) }
  it { should validate_presence_of(:account_number_to) }
  it { should validate_presence_of(:country_code_from) }
  it { should validate_presence_of(:country_code_to) }
end
