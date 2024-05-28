# frozen_string_literal: true
module UserErr
class UserExistError < BaseError
  def initialize(msg = 'Bad youtube url',
                 error_code_id: ErrorCode::PARAMETER_MISSING_ERR,
                 error_code_data: nil)
    super
  end
end

class NoUserErr < BaseError
  def initialize(msg = 'Invalid Login',
                 error_code_id: ErrorCode::AUTHORIZATION_ERR,
                 error_code_data: nil)
    super
  end
end
end
