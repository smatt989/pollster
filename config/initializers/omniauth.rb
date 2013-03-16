Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '139927366179095', 'ef15a029b5cc6fba91c661d02b4b700c'
end