Rails.application.config.middleware.use OmniAuth::Builder do
  SETUP_PROC = lambda do |env|
    request = Rack::Request.new(env)
    env['omniauth.strategy'].options[:scope] = "user_birthday"
  end

  provider :facebook, '139927366179095', 'ef15a029b5cc6fba91c661d02b4b700c', setup: SETUP_PROC
end