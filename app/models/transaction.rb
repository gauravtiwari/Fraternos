class Transaction < ApplicationRecord
  belongs_to :fraternity
  belongs_to :user

  validates :amount, presence: true
end
