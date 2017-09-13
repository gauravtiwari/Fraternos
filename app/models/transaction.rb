class Transaction < ApplicationRecord
  belongs_to :fraternity
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: -9999, less_than_or_equal_to: 9999 }

  after_validation do
    self.amount = amount.to_f.abs
    self.amount = amount * -1 if type == 'Debt'
  end
end
