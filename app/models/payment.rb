class Payment < Transaction
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
