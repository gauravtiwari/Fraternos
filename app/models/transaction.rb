class Transaction < ApplicationRecord
  belongs_to :membership

  validates :amount, presence: true, numericality: true
end
