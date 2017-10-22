require 'rails_helper'

RSpec.describe User, type: :model do

	describe "Associations" do
  	it { should have_many(:transfers).dependent(:destroy) }
  end
  
  describe "Validations" do
	  it { should validate_presence_of(:first_name) }
	  it { should validate_presence_of(:last_name) }
	  it { should validate_presence_of(:address_line_1) }
	  it { should validate_presence_of(:date_of_birth) }

	  it { should validate_length_of(:first_name).is_at_most(20) }
	  it { should validate_length_of(:last_name).is_at_most(20) }
	  it { should validate_length_of(:address_line_1).is_at_most(50) }
	end

	describe "instance methods" do
		it 'returns valid name' do
			user = create(:user, first_name: 'Adam', last_name: 'Green')
			expect(user.name).to eq('Adam Green')
		end

		it 'returns valid age in years' do
			Timecop.freeze(Date.new(2017,1,1)) do
				user = create(:user, date_of_birth: DateTime.new(1993,01,01))
				expect(user.age).to eq(24)
			end
		end
	end
end
