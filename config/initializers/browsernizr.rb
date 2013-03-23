Rails.application.config.middleware.use Browsernizer::Router do |config|
  # we're just looking to block IE 7 and less, any browser not listed
  # is assumed to be supported.
  config.supported "Internet Explorer", "9"
  config.location  "/unsupported.html"
  config.exclude   %r{^/assets}
end

