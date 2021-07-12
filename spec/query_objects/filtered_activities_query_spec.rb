# frozen_string_literal: true

require "rails_helper"

describe FilteredActivitiesQuery do
  subject(:query) { described_class.new(Activity.all, filter_params) }

  let!(:activity1) { create :activity }
  let!(:activity2) { create :activity, event: :user_updated }

  let(:filter_params) { {} }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to match_array([activity1, activity2]) }

    context "when param is user_updated" do
      let(:filter_params) { { events: [:user_updated] } }

      it { is_expected.to match_array([activity2]) }
    end

    context "when param is empty" do
      let(:filter_params) { { events: [] } }

      it { is_expected.to be_empty }
    end
  end
end
