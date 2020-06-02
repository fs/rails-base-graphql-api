require "rails_helper"

describe CreateAccessToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, token_payload: token_payload } }
  let(:user) { create :user, id: 111_111 }

  describe ".call" do
    context "with existing jti" do
      let(:token_payload) { { jti: "biTuVh1FadmboHL03yscGXr6/D/V0BCDoKQ" } }
      let(:expected_jti) { "7fc6d21913811be48db74417f9a26598" }
      let(:expected_access_token) do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiI3ZmM2ZDIxOTEzODExYmU0OGRiN"\
        "zQ0MTdmOWEyNjU5OCIsInR5cGUiOiJhY2Nlc3MifQ.e-wdSHA4hdSL3NzSrQMzPb1ggFCJDgRW_MGrcXPHwPM"
      end

      it_behaves_like "success interactor"

      it "generates access token and jti for user" do
        interactor.run

        expect(context.access_token).to eq(expected_access_token)
        expect(context.jti).to eq(expected_jti)
      end
    end

    context "with generate jti" do
      let(:token_payload) { nil }
      let(:current_time) { Time.zone.local(2020, 12, 10, 12, 30) }
      let(:expected_jti) { "091c7398db7e1fb198a2d25d83ea8be1" }
      let(:expected_access_token) do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNjA3NjA3MDAwLCJqdGkiOiIwOTFjNzM5OGRiN2UxZmIx"\
        "OThhMmQyNWQ4M2VhOGJlMSIsInR5cGUiOiJhY2Nlc3MifQ.gurUTyx8Cli8rNn8fpNv-2oRtd2-PGls6j6XlIurFSk"
      end

      it_behaves_like "success interactor"

      it "generates access token and jti for user" do
        interactor.run

        expect(context.access_token).to eq(expected_access_token)
        expect(context.jti).to eq(expected_jti)
      end
    end
  end
end
