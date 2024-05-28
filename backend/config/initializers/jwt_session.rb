JWTSessions.algorithm = "HS256"
JWTSessions.access_exp_time = ENV['ACCESS_KEY_EXPIRE_TIME'] || 3600
JWTSessions.refresh_exp_time = ENV['REFRESH_KEY_EXPIRE_TIME'] || 604800
JWTSessions.signing_key = ENV['ACCESS_KEY']

JWTSessions.token_store =:memory if Rails.env.test?
