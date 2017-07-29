class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :fraternity

  enum role: { owner: 0, admin: 1, member: 2 }

  validates :role, presence: true

  delegate :email, :name, to: :user

  def to_s
    return '' unless name_present?
    nickname.present? ? nickname : user.name
  end

  def name_present?
    nickname.present? || user.name.present?
  end
end
