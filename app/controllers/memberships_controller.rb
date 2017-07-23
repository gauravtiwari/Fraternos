class MembershipsController < ApplicationController
  def index
    authorize fraternity, policy_class: MembershipPolicy
    load_memberships
  end

  def new
    load_fraternity
    authorize fraternity, policy_class: MembershipPolicy
    @membership_form = MembershipForm.new
  end

  def create
    load_fraternity
    authorize fraternity, policy_class: MembershipPolicy
    @membership_form = MembershipForm.new(membership_params)

    if @membership_form.valid?
      CreateMembership.call(fraternity: fraternity, **@membership_form.attributes)

      redirect_to fraternity_memberships_path(fraternity), notice: notification_for(:invited, User)
    else
      render :new
    end
  end

  def edit
    load_membership
    authorize @membership
  end

  def update
    load_membership
    authorize @membership
    build_membership

    if @membership.save
      redirect_to fraternity_memberships_path(@membership.fraternity), notice: notification_for(:updated, Membership)
    else
      render :edit
    end
  end

  def destroy
    load_membership
    authorize @membership

    options =
      if @membership.destroy
        { notice: notification_for(:destroyed, Membership) }
      else
        { flash: { alert: notification_for(:not_destroyed, Membership) } }
      end

    redirect_to fraternity_memberships_path(@membership.fraternity), options
  end

  private

  def membership_params
    params.fetch(:membership, {}).permit(:email, :nickname, :role)
  end

  def build_membership
    @membership ||= membership_scope.build
    @membership.attributes = membership_params
  end

  def load_membership
    @membership ||= membership_scope.find_by(id: params[:id])
  end

  def load_memberships
    @memberships ||= membership_scope.includes(:user)
  end

  def membership_scope
    fraternity&.memberships || Membership.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
  alias load_fraternity fraternity
end
