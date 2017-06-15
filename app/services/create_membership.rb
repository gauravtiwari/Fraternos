class CreateMembership < Service::Base
  def self.call(email, nickname, fraternity)
    member = User.invite!(email: email)
    member
      .memberships
      .create_with(nickname: nickname, role: :member)
      .find_or_create_by(fraternity: fraternity)
  end
end
