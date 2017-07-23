class CreateFraternity < Service::Base
  attribute :name, Types::String
  attribute :user, Types::Class

  def call
    fraternity = Fraternity.create(name: name)
    user.memberships.create(fraternity: fraternity, role: :owner)
    success(fraternity)
  end
end
