class Transaction < ApplicationRecord
  belongs_to :membership

  delegate :fraternity_id, to: :membership

  validates :amount, presence: true, numericality: true
end
