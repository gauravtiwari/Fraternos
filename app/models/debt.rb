class Debt < Transaction
  validates :amount, presence: true, numericality: { less_than: 0 }
end
