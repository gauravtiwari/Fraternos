require 'rails_helper'

describe MembershipPolicy do
  subject { described_class }

  let(:fraternity) { create(:fraternity, :with_members) }
  let(:record) { create(:membership, fraternity: fraternity) }

  %i[owner].each do |role|
    context "as #{role}" do
      permissions :update?, :destroy? do
        it('grants access') {
          is_expected.to permit(fraternity.owner.user, record)
        }
      end
    end
  end

  context 'as admin' do
    let(:user) { create(:user) }
    let(:admin) { create(:membership, user: user, role: :admin, fraternity: fraternity) }

    permissions :destroy? do
      it('grants access') { is_expected.to permit(admin.user, record) }
    end

    permissions :update? do
      it('denies access') { is_expected.to_not permit(admin.user, record) }
    end
  end

  %i[member].each do |role|
    context "as #{role}" do
      let(:user) { create(:user) }
      let(:member) { build(:membership, user: user, role: role, fraternity: fraternity) }

      permissions :update?, :destroy? do
        it('denies access') { is_expected.to_not permit(member.user, record) }
      end
    end
  end
end
