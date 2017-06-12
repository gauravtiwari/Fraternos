class User < ApplicationRecord
  include SoftDeletable

  devise(
    :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable, :lockable
  )

  has_many :memberships
  has_many :fraternities, through: :memberships
  has_many :organizer_assignations, foreign_key: :organizer_id
  has_many :meetings, through: :organizer_assignations

  validates :name, presence: true

  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
