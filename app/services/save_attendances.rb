class SaveAttendances
  def self.call(meeting, present_user_ids)
    meeting.fraternity.users.find_each do |user|
      meeting.attendance_records.create(
        user: user, presence: present_user_ids.includes?(user.id)
      )
    end
  end
end
