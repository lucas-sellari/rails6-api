class AuthenticationTokenService
  HMAC_SECRET = "mysecretkey"
  ALGORITHM_TYPE = "HS256"
  def self.call(user_id) #self defines the methods as a class methods
    payload = { user_id: user_id }

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end