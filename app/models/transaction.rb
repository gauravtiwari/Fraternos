class Transaction < ApplicationRecord
  belongs_to :membership

  delegate :fraternity_id, to: :membership

  validates :amount, presence: true, numericality: { less_than: 1_000_000, greater_than: -1_000_000 }
end
