class PaymentsController < ApplicationController
  def new
    build_payment
    authorize @payment
  end

  def create
    build_payment
    authorize @payment

    if @payment.save
      redirect_to fraternity_path(params[:fraternity_id])
    else
      render :new
    end
  end

  private

  def payment_params
    params.fetch(:debt, {}).permit(:amount, :user_id)
  end

  def build_payment
    @payment ||= payment_scope.build
    @payment.attributes ||= payment_params
  end

  def load_payment
    payment_scope.find(params[:id])
  end

  def payment_scope
    fraternity.payments.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
