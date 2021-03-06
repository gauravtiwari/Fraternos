class TransactionsController < ApplicationController
  def index
    authorize @fraternity, :show?
    load_transactions
  end

  def show
    load_transaction
    authorize @transaction
  end

  def create
    build_transaction
    authorize @transaction

    if @transaction.save
      redirect_to fraternity_memberships_path(fraternity), notice: notification_for(:created, Transaction)
    else
      redirect_to fraternity_memberships_path(fraternity)
    end
  end

  private

  def transaction_params
    params.fetch(:transaction, {}).permit(:amount, :membership_id)
  end

  def build_transaction
    @transaction ||= transaction_scope.build
    @transaction.attributes = transaction_params
  end

  def load_transaction
    transaction_scope.find(params[:id])
  end

  def load_transactions
    transaction_scope
  end

  def transaction_scope
    fraternity.transactions.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
