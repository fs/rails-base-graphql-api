RSpec::Matchers.define :have_jwt_token_payload do |expected_payload|
  match do |token|
    token_payload = JWT.decode(token, nil, false, algorithm: "HS256").first

    expect(token_payload.size).to eq(expected_payload.size)
    expect(token_payload).to include(expected_payload.stringify_keys)
  end
end
