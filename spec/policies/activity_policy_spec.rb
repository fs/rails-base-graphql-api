require "rails_helper"

describe ActivityPolicy do
  let(:user) { build_stubbed(:user, first_name: first_name) }
  let(:context) { { user: user } }

  describe "#relation_scope" do
    subject { policy.apply_scope(Activity.all, type: :active_record_relation) }

    let!(:own_private_event) { create(:activity, :private, user: another_user) }
    let!(:public_event) { create(:activity, :public) }
    let(:another_user) { create(:user) }
    let(:user) { another_user }

    before { create(:activity, :private) }

    it { is_expected.to contain_exactly(own_private_event, public_event) }

    context "when user is not defined" do
      let(:user) { nil }

      it { is_expected.to contain_exactly(public_event) }
    end
  end
end
