class MembershipPolicy < ApplicationPolicy
  def index?
    user.memberships.exists?(fraternity: fraternity)
  end

  def create?
    user.owns_fraternity?(fraternity) || fraternity_admin?
  end

  def update?
    user.owns_fraternity?(fraternity) || fraternity_admin?
  end

  def destroy?
    return false if user.owns_fraternity?(fraternity)
    fraternity_admin? || user.memberships.exists?(record.id)
  end
end
