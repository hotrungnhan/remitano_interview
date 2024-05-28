# frozen_string_literal: true

# code refers to HTTP Status Code to be returned
# schema refers to JSON schema response in String

RSpec.shared_examples 'an HTTP response with status code' do |code|
  it "returns #{code} HTTP status code" do
    expect(response.status).to eq code
  end
end
