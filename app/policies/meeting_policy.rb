class MeetingPolicy < ApplicationPolicy
  alias meeting record

  def show?
    user.administrates_fraternity?(meeting.fraternity_id)
  end

  def create?
    user.administrates_fraternity?(meeting.fraternity_id)
  end

  def update?
    user.administrates_fraternity?(meeting.fraternity_id)
  end
end
