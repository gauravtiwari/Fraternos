class Meeting < ApplicationRecord
  belongs_to :fraternity

  has_many :organizer_assignations
  has_many :organizers, through: :organizer_assignations, source: :organizer
  has_many :attendance_records

  scope :upcoming, -> { where('date >= ?', Time.zone.today).order(:date) }

  validates :date, presence: true
end
