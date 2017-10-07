class MembershipPolicy < ApplicationPolicy
  alias membership record

  def update?
    user.administrates_fraternity?(membership.fraternity_id)
  end

  def destroy?
    user.administrates_fraternity?(membership.fraternity_id) ||
      user.id == membership.user_id
  end
end
