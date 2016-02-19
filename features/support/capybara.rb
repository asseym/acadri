require 'capybara/cucumber'
Capybara.app_host = 'http://localhost:3000'

# Capybara.default_driver = :selenium

Capybara.server do |app, port|
  require 'rack/handler/webrick'
  Rack::Handler::WEBrick.run(app, :Port => port, :AccessLog => [], :Logger => WEBrick::Log::new(Rails.root.join("log/capybara_test.log").to_s))
end