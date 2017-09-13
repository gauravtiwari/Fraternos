class TransactionsController < ApplicationController
  def index
    authorize Transaction
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

  def transaction_type
    params.slice(:debt, :payment).keys.first.classify
  end

  def transaction_params
    params.fetch(:transaction, {}).permit(:amount, :user_id)
  end

  def build_transaction
    @transaction ||= transaction_scope.build
    @transaction.attributes = transaction_params.merge(type: transaction_type)
  end

  def load_transaction
    transaction_scope.find(params[:id])
  end

  def load_transactions
    transaction_scope.where(user_id: params[:user_id])
  end

  def transaction_scope
    fraternity.transactions.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
