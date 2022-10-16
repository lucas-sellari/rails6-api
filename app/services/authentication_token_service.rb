class AuthenticationTokenService
  HMAC_SECRET = "mysecretkey"
  ALGORITHM_TYPE = "HS256"
  def self.call #self defines the methods as a class methods
    payload = { "test" => "bla" }

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end