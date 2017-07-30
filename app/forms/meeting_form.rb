class MeetingForm
  include ActiveModel::Model

  attr_accessor :starts_on, :ends_on, :frequency, :organizers

  validates :starts_on, :ends_on, :frequency, :organizers, presence: true

  def attributes
    {
      starts_on: starts_on,
      ends_on: ends_on,
      frequency: frequency.to_i,
      organizers: organizers.to_i
    }
  end
end
