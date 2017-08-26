class Fraternity < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :meetings, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true

  def owner
    memberships.find_by(role: :owner)
  end

  def next_meeting
    meetings&.upcoming&.first
  end
end
