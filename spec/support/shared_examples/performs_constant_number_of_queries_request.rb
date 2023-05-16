shared_examples "performs constant number of queries request" do
  specify do
    expect { ApplicationSchema.execute(query).as_json }
      .to perform_constant_number_of_queries
  end
end
