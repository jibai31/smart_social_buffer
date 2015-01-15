FactoryGirl.define do
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    uid: '12345',
    info: { name: 'John Doe', image: '' },
    credentials: { token: "abc_def", secret: "123_456" },
    extra: { raw_info: { locale: "fr" }, access_token: { token: 'ABC', secret: '123' } }
  })

  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '12345',
    info: { email: 'john.doe@example.com', name: 'John Doe', image: '' },
    credentials: { token: "abc_def", secret: "123_456" },
    extra: { raw_info: { locale: "fr" } }
  })

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '12345',
    info: { email: 'john.doe@example.com', name: 'John Doe', image: '' },
    credentials: { token: "abc_def", secret: "123_456" },
    extra: { raw_info: { locale: "fr" } }
  })
end
