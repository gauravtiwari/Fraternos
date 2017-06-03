class CreateFraternity
  def self.call(name, user)
    Fraternity.create(name: name).tap do |fraternity|
      user.memberships.create(fraternity: fraternity, role: :owner)
    end
  end
end
