10.times do |index|
  User.create(email: "user#{index}@example.com", password: 'password').confirm
end

fraternity = CreateFraternity.call('Sarasaó', User.first)

User.where.not(id: User.first.id).each do |user|
  fraternity.memberships.create(user: user, role: :member)
end

GenerateMeetings.call(
  fraternity,
  frequency: 7,
  organizers: 2,
  starts_on: Date.today,
  ends_on: Date.today + 1.month
)
