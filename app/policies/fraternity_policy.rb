class FraternityPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.memberships.exists?(fraternity: record)
  end

  def create?
    true
  end

  def update?
    user.owns_fraternity?(record)
  end

  def destroy?
    user.owns_fraternity?(record)
  end
end
