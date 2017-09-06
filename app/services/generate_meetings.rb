class GenerateMeetings < Service::Base
  attribute :fraternity, Types::Class
  attribute :organizers, Types::Int
  attribute :dates, Types::String

  def call
    organizers_pool = fraternity.users.shuffle

    ActiveRecord::Base.transaction do
      dates.split(', ').each do |date|
        meeting = fraternity.meetings.create(date: date)

        organizers.times do
          organizers_pool = fraternity.users.shuffle if organizers_pool.empty?
          meeting.organizer_assignations.create(organizer: organizers_pool.shift)
        end
      end
    end

    success
  end
end
