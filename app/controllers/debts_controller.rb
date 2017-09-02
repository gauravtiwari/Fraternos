class DebtsController < ApplicationController
  def create
    build_debt
    authorize @debt

    if @debt.save
      redirect_to fraternity_memberships_path(fraternity), notice: notification_for(:created, Debt)
    else
      redirect_to fraternity_memberships_path(fraternity)
    end
  end

  private

  def debt_params
    params.fetch(:debt, {}).permit(:amount, :user_id)
  end

  def build_debt
    @debt ||= debt_scope.build
    @debt.attributes = debt_params
  end

  def load_debt
    debt_scope.find(params[:id])
  end

  def debt_scope
    fraternity.debts.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
