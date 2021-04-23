require "rails_helper"

describe ActivityPolicy do
  subject(:policy) { described_class.new(user: current_user) }

  describe "#relation_scope" do
    subject(:relation_scope) { policy.authorized_scope(Activity.all) }

    let!(:own_private_event) { create(:activity, :private, user: user) }
    let!(:public_event) { create(:activity, :public) }
    let(:user) { create(:user) }
    let(:current_user) { user }

    before { create(:activity, :private) }

    it "returns user events" do
      expect(relation_scope).to match_array([own_private_event, public_event])
    end

    context "when user is not defined" do
      let(:current_user) { nil }

      it "returns only public events" do
        expect(relation_scope).to match_array([public_event])
      end
    end
  end
end
