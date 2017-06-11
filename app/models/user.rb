class User < ApplicationRecord
  devise(
    :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable, :lockable
  )

  has_many :memberships
  has_many :fraternities, through: :memberships
  has_many :organizer_assignations, foreign_key: :organizer_id
  has_many :meetings, through: :organizer_assignations

  validates :name, presence: true
end
