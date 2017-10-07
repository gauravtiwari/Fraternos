class User < ApplicationRecord
  include SoftDeletable

  devise(
    :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable, :lockable, :invitable
  )

  has_many :memberships, dependent: :destroy
  has_many :fraternities, through: :memberships
  has_many :owned_fraternities, -> { where(memberships: { role: :owner }) }, through: :memberships, source: :fraternity
  has_many :organizer_assignations, foreign_key: :organizer_id, dependent: :destroy
  has_many :meetings, through: :organizer_assignations
  has_many :transactions, through: :memberships, dependent: :destroy

  validates :name, presence: true

  def to_s
    name || email
  end

  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def administrates_fraternity?(fraternity)
    memberships.exists?(role: %i[owner admin], fraternity: fraternity)
  end

  def owns_fraternity?(fraternity)
    owned_fraternities.exists?(id: fraternity)
  end
end
