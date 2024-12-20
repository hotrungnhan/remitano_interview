# frozen_string_literal: true

require 'oj'

class JsonHash
  def self.json_string_to_hash(json)
    Oj.load(json).try(:with_indifferent_access)
  end
end
