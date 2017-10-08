class TransactionPolicy < ApplicationPolicy
  alias transaction record

  def show?
    user.administrates_fraternity?(transaction.fraternity_id)
  end

  def create?
    user.administrates_fraternity?(transaction.fraternity_id)
  end
end
