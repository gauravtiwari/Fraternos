class OrganizerAssignation < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  belongs_to :meeting, required: false

  validates :organizer_id, uniqueness: { scope: :meeting_id }
end
