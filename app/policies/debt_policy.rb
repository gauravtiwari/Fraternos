class DebtPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    fraternity_admin?
  end
end
