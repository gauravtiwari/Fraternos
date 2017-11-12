require 'rails_helper'

describe FraternityPolicy do
  subject { described_class }

  let(:fraternity) { create(:fraternity, :with_members) }
  let(:record) { create(:membership, fraternity: fraternity) }

  context 'as owner' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it('grants access') {
        is_expected.to permit(fraternity.owner.user, fraternity)
      }
    end
  end

  %i[admin member].each do |role|
    context "as #{role}" do
      let(:user) { build(:user) }
      let(:member) { build(:membership, user: user, role: role, fraternity: fraternity) }

      permissions :show? do
        it('grants access') { is_expected.to_not permit(member.user, record) }
      end
      permissions :update?, :destroy? do
        it('denies access') { is_expected.to_not permit(member.user, record) }
      end
    end
  end
end
