class Transaction < ApplicationRecord
  belongs_to :fraternity
  belongs_to :user

  validates :date, presence: true
end
