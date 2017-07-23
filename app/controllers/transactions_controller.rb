class TransactionsController < ApplicationController
  def index
    authorize Transaction
    load_transactions
  end

  def show
    load_transaction
    authorize @transaction
  end

  private

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
