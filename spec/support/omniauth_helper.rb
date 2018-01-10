module OmniauthHelper

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "test@test.com",
        first_name: "test",
        last_name: "user"
      }
    })
  end
end
