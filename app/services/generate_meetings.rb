class GenerateMeetings < Service::Base
  attribute :fraternity, Types::Class
  attribute :frequency, Types::Int
  attribute :organizers, Types::Int
  attribute :starts_on, Types::DateTime
  attribute :ends_on, Types::DateTime

  def call
    organizers_pool = fraternity.users.shuffle

    ActiveRecord::Base.transaction do
      (starts_on..ends_on).step(frequency).each do |date|
        meeting = fraternity.meetings.create(date: date)
        # TODO: fix incorrect 30/31 date, trying to create inexisting 31 months
        organizers.times do
          organizers_pool = fraternity.users.shuffle if organizers_pool.empty?
          meeting.organizer_assignations.create(organizer: organizers_pool.shift)
        end
      end
    end

    success
  end
end
