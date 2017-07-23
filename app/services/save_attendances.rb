class SaveAttendances < Service::Base
  attribute :meeting, Types::Class
  attribute :present_user_ids, Types::Array

  def call
    meeting.fraternity.users.find_each do |user|
      meeting.attendance_records.create(
        user: user, presence: present_user_ids.includes?(user.id)
      )
    end

    success
  end
end
