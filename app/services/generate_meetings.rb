class GenerateMeetings
  def self.call(fraternity, options = {})
    frequency  = options[:frequency]
    organizers = options[:organizers]
    starts_on  = options[:starts_on]
    ends_on    = options[:ends_on]

    organizers_pool = fraternity.users.shuffle

    (starts_on..ends_on).step(frequency).each do |date|
      meeting = fraternity.meetings.create(date: date)

      organizers.times do
        organizers_pool = fraternity.users.shuffle if organizers_pool.empty?
        meeting.organizer_assignations.create(organizer: organizers_pool.shift)
      end
    end
  end
end
