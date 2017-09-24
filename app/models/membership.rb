class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :fraternity

  has_many :transactions, dependent: :destroy

  enum role: { owner: 0, admin: 1, member: 2 }

  validates :role, presence: true

  delegate :email, :name, to: :user

  def to_s
    name || nickname || ''
  end

  def balance
    transactions.sum(:amount)
  end
end
