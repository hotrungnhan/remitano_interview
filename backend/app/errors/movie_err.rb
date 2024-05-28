# frozen_string_literal: true

module MovieErr

class BadYoutubeUrlErr < BaseError
  def initialize(msg = 'Invalid provider',
                 error_code_id: ErrorCode::PARAMETER_MISSING_ERR,
                 error_code_data: nil)
    super
  end
end

class FetchMetadataErr < BaseError
  def initialize(msg = 'Invalid provider',
                 error_code_id: ErrorCode::PARAMETER_MISSING_ERR,
                 error_code_data: nil)
    super
  end
end

end
