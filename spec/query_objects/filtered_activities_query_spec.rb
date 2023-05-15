# frozen_string_literal: true

require "rails_helper"

describe FilteredActivitiesQuery do
  subject(:query) { described_class.new(Activity.all, filter_params) }

  let!(:first_activity) { create(:activity) }
  let!(:second_activity) { create(:activity, event: :user_updated) }

  let(:filter_params) { {} }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to contain_exactly(first_activity, second_activity) }

    context "when param is user_updated" do
      let(:filter_params) { { events: [:user_updated] } }

      it { is_expected.to contain_exactly(second_activity) }
    end

    context "when param is empty" do
      let(:filter_params) { { events: [] } }

      it { is_expected.to be_empty }
    end
  end
end
