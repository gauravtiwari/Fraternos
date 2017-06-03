class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :fraternity

  enum role: %i[owner admin member]

  validates :role, presence: true
end
