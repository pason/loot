require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end
  
  describe "Validations" do
    it { should validate_presence_of(:account_number_from) }
    it { should validate_presence_of(:account_number_to) }
    it { should validate_presence_of(:country_code_from) }
    it { should validate_presence_of(:country_code_to) }

    it { should validate_length_of(:account_number_from).is_equal_to(18) }
    it { should validate_length_of(:account_number_to).is_equal_to(18) }
    it { should validate_length_of(:country_code_from).is_equal_to(3) }
    it { should validate_length_of(:country_code_to).is_equal_to(3) }
  end
end
