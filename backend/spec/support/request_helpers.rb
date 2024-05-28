require 'json-schema'

def check_json_schema(json, schema)
  if schema.class == String
    schema_directory = "#{Dir.pwd}/spec/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, json)
  else # if {} is received instead of 'filename' for example
    JSON::Validator.validate!(schema, json)
  end
end

RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    check_json_schema(response.body, schema)
  end
end

RSpec::Matchers.define :match_json_schema do |schema|
  match do |json|
    check_json_schema(json, schema)
  end
end

RSpec::Matchers.define_negated_matcher :avoid_changing, :change

module Requests
  module JsonHelpers
    # can only fetch the whole JSON object or up to one level below root only
    def response_hash
      Oj.load(response.body).with_indifferent_access
    end

    def default_fake_uuid
      'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa'
    end
  end
end
