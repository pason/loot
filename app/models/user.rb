class User < ApplicationRecord
  include Authenticatable

  has_secure_password
  
  has_many :transfers, dependent: :destroy

  validates :first_name, length: { maximum: 20 }, presence: true
  validates :last_name, length: { maximum: 20 }, presence: true
  validates :address_line_1, length: { maximum: 50 }, presence: true
  validates :date_of_birth, presence: true

  def name
  	first_name.strip + ' ' + last_name.strip
  end

  def age
  	now = Time.now.utc.to_date
  	now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
  end
end
