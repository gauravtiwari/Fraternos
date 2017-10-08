class Meeting < ApplicationRecord
  belongs_to :fraternity

  has_many :organizer_assignations, dependent: :destroy
  has_many :organizers, through: :organizer_assignations, source: :organizer
  has_many :attendance_records, dependent: :destroy

  scope :upcoming, -> { where('date >= ?', Time.zone.today).order(:date) }
  scope :ordered, -> { order(date: :asc) }

  validates :date, presence: true

  def organizers_names
    organizers.map(&:name).join(' & ')
  end
end
