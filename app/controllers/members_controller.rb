class MembersController < ApplicationController
  def index
    load_members
  end

  def new
    build_member
  end

  def create
    @member = User.invite!(member_params)
    @member.memberships.create_with(role: :member).find_or_create_by(fraternity: fraternity)

    redirect_to fraternity_members_path(fraternity), notice: notification_for(:invited, User)
  end

  private

  def build_member
    @member ||= member_scope.build
    @member.attributes = member_params
  end

  def load_members
    @members ||= member_scope
  end

  def load_member
    @member ||= member_scope.find_by(id: params[:id])
  end

  def member_params
    params.fetch(:member, {}).permit(:name, :email)
  end

  def member_scope
    fraternity&.users
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
