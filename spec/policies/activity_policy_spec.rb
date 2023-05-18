require "rails_helper"

describe ActivityPolicy do
  let(:context) { { user: user } }
  let(:user) { create(:user) }

  describe "#relation_scope" do
    subject { policy.apply_scope(Activity.all, type: :active_record_relation) }

    let!(:own_private_event) { create(:activity, :private, user: user) }

    before do
      create(:activity, :public)
      create(:activity, :private)
    end

    it { is_expected.to contain_exactly(own_private_event) }
  end
end
