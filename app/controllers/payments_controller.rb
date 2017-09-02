class PaymentsController < ApplicationController
  def create
    build_payment
    authorize @payment

    if @payment.save
      redirect_to fraternity_memberships_path(fraternity), notice: notification_for(:created, Payment)
    else
      redirect_to fraternity_memberships_path(fraternity)
    end
  end

  private

  def payment_params
    params.fetch(:payment, {}).permit(:amount, :user_id)
  end

  def build_payment
    @payment ||= payment_scope.build
    @payment.attributes = payment_params
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
