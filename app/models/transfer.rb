class Transfer < ApplicationRecord

  belongs_to :user

  validates :account_number_from, length: { is: 18 }, presence: true
  validates :account_number_to, length: { is: 18 }, presence: true
  validates :amount_pennies, numericality: { only_integer: true }
  validates :country_code_from, length: { is: 3 }, presence: true
  validates :country_code_to, length: { is: 3 }, presence: true
end
