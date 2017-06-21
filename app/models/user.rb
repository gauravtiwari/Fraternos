class User < ApplicationRecord
  include SoftDeletable

  devise(
    :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable, :lockable, :invitable
  )

  has_many :memberships, dependent: :destroy
  has_many :fraternities, through: :memberships
  has_many :organizer_assignations, foreign_key: :organizer_id, dependent: :destroy
  has_many :meetings, through: :organizer_assignations

  validates :name, presence: true

  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def role_on(fraternity)
    membership_for(fraternity).role
  end

  def membership_for(fraternity)
    memberships.find_by(fraternity: fraternity)
  end
end
