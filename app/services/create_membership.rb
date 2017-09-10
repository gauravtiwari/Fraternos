class CreateMembership < ApplicationService
  attribute :email, Types::String
  attribute :nickname, Types::String
  attribute :fraternity, Types::Class

  def call
    member = User.invite!(email: email, name: nickname)
    member
      .memberships
      .create_with(nickname: nickname, role: :member)
      .find_or_create_by(fraternity: fraternity)

    success(member)
  end
end
