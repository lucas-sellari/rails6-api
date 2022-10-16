require "rails_helper"

describe "Authentication", type: :request do
  describe "POST /authenticate" do
    let(:user) { FactoryBot.create(:user, username: "BookSeller99", password: "12345") } # lazy load, only run when it is called

    it "authenticates the client" do
      post "/api/v1/authenticate", params: { username: user.username, password: "12345" }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
        "token" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.A6ScM3oxFTv8xsngqF73oJQsHHczND0BI4sdnTOm1gE"
      })
    end

    it "returns error when username is missing" do
      post "/api/v1/authenticate", params: { password: "password123" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        "error" => "param is missing or the value is empty: username"
      })
    end

    it "return error when password is missing" do
      post "/api/v1/authenticate", params: { username: "BookSeller99" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        "error" => "param is missing or the value is empty: password"
      })
    end

    it "returns error when password is incorrect" do
      post "/api/v1/authenticate", params: { username: user.username, password: "111" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end