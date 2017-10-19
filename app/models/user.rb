class User < ApplicationRecord

  has_many :transfers, dependent: :destroy

  validates :first_name, length: { maximum: 20 }, presence: true
  validates :last_name, length: { maximum: 20 }, presence: true
  validates :address_line_1, length: { maximum: 50 }, presence: true
  validates :date_of_birth, presence: true
end
