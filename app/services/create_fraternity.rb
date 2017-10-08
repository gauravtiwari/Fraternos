class CreateFraternity < ApplicationService
  attribute :name, Types::String
  attribute :user, Types::Instance(User)

  def call
    fraternity = Fraternity.create(name: name)
    user.memberships.create(fraternity: fraternity, role: :owner)
    success(fraternity)
  end
end
