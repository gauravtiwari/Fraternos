class MeetingForm
  include ActiveModel::Model

  attr_accessor :dates, :organizers

  validates :dates, :organizers, presence: true

  def attributes
    {
      dates: dates.split(', '),
      organizers: organizers.to_i
    }
  end
end
