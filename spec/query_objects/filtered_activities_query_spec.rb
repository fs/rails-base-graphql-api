# frozen_string_literal: true

require "rails_helper"

describe FilteredActivitiesQuery do
  subject(:query) { described_class.new(Activity.all, filter_params) }

  let!(:activity_1) { create :activity }
  let!(:activity_2) { create :activity, event: :user_updated }

  let(:filter_params) { {} }

  describe "#all" do
    subject(:all) { query.all }

    it { is_expected.to match_array([activity_1, activity_2]) }

    context "when filtered by event" do
      let(:filter_params) { { event: nil } }

      it { is_expected.to match_array([activity_1, activity_2]) }

      context "when param is user_updated" do
        let(:filter_params) { { event: [:user_updated] } }

        it { is_expected.to match_array([activity_2]) }
      end

      context "when param is user_registered" do
        let(:filter_params) { { event: [:user_registered] } }

        it { is_expected.to match_array([activity_1]) }
      end
    end
  end
end
