class MembershipsController < ApplicationController
  def destroy
    load_membership

    options =
      if @membership.destroy
        { notice: notification_for(:destroyed, Membership) }
      else
        { flash: { alert: notification_for(:not_destroyed, Membership) } }
      end

    redirect_to fraternity_members_path(@membership.fraternity), options
  end

  private

  def membership_params
    params.fetch(:membership, {}).permit
  end

  def build_membership
    @membership ||= membership_scope.build
    @membership.attributes = membership_params
  end

  def load_membership
    @membership ||= membership_scope.find_by(id: params[:id])
  end

  def membership_scope
    fraternity&.memberships || Membership.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
