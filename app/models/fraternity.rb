class Fraternity < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :meetings, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
end
