class Fraternity < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :meetings, dependent: :destroy
  has_many :transactions, through: :memberships, dependent: :destroy

  validates :name, presence: true
  validates :absent_penalty, numericality: { greater_than_or_equal_to: -9999, less_than_or_equal_to: 0 }

  def owner
    memberships.find_by(role: :owner)
  end

  def next_meeting
    meetings&.upcoming&.first
  end

  def balance
    transactions.sum(:amount)
  end
end
