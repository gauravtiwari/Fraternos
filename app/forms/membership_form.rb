class MembershipForm
  include ActiveModel::Model

  attr_accessor :email, :nickname

  validates :email, :nickname, presence: true
end
