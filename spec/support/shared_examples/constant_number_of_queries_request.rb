shared_examples "constant number of queries request" do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  context "when N+1", :n_plus_one do
    specify do
      expect { response }.to perform_constant_number_of_queries
    end
  end
end
