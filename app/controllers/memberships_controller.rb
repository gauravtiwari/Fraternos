class MembershipsController < ApplicationController
  def destroy
    load_membership
    if @membership.destroy
      redirect_to fraternities_path, notice: notification_for(:destroyed, Membership)
    else
      redirect_to root_url, flash: { alert: notification_for(:not_destroyed, Membership) }
    end
  end

  private

  def load_membership
    @membership ||= membership_scope.find_by(user_id: params[:id])
  end

  def membership_scope
    fraternity&.memberships
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end