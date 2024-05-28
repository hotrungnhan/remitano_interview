# frozen_string_literal: true

# code refers to HTTP Status Code to be returned
# schema refers to JSON schema response in String

RSpec.shared_examples 'an HTTP response with status code' do |code|
  it "returns #{code} HTTP status code" do
    expect(response.status).to eq code
  end
end

RSpec.shared_examples 'an HTTP response' do |code, schema|
  it "returns HTTP response body matching the '#{schema}' response schema and #{code} code" do
    expect(response.status).to eq code
    expect(response).to match_response_schema(schema)
  end
end

RSpec.shared_examples 'an HTTP header-only response' do |code|
  include_examples 'an HTTP response with status code', code
  it 'returns empty HTTP response body' do
    expect(response.body).to eq ''
  end
end

RSpec.shared_examples 'an HTTP error response' do |code|
  include_examples 'an HTTP response', code, 'errors'
end

RSpec.shared_examples 'an HTTP error response with error message' do |code, expected_messages|
  it 'returns correct error messages and code' do
    expect(response.status).to eq code
    errors = JSON.parse(response.body)['errors']
    expect(errors.count).to eq expected_messages.count
    errors.each do |actual_message|
      expect(expected_messages.include?(actual_message)).to be true
    end
  end
end
