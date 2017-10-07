class SaveAttendances < ApplicationService
  attribute :meeting, Types::Instance(Meeting)
  attribute :absent_user_ids, Types::Array(Types::Form::Int)

  def call
    ActiveRecord::Base.transaction do
      meeting.fraternity.users.find_each do |user|
        record = meeting.attendance_records.create(user: user, presence: user_attended?(user))

        if !record.presence? && penalty?
          fraternity
            .memberships
            .find_by(user_id: user.id)
            .transactions
            .create(amount: fraternity.absent_penalty)
        end
      end
    end

    success
  end

  def user_attended?(user)
    absent_user_ids.exclude?(user.id)
  end

  def fraternity
    @fraternity ||= meeting.fraternity
  end

  def penalty?
    fraternity.absent_penalty.negative?
  end
end
