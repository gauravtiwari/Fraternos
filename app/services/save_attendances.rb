class SaveAttendances < Service::Base
  attribute :meeting, Types::Class
  attribute :absent_user_ids, Types::Array

  def call
    ActiveRecord::Base.transaction do
      meeting.fraternity.users.find_each do |user|
        record = meeting.attendance_records.create(user: user, presence: absent_user_ids.exclude?(user.id.to_s))

        if !record.presence? && penalty?
          user.debts.create(fraternity_id: meeting.fraternity.id, amount: meeting.fraternity.absent_penalty)
        end
      end
    end

    success
  end

  def penalty?
    meeting.fraternity.absent_penalty.negative?
  end
end
