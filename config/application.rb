require File.expand_path('../boot', __FILE__)

require 'rails/all'
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "active_model/railtie"
# require "action_view/railtie"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Serp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # add custom validators path
    config.autoload_paths += %W["#{config.root}/app/validators/"]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.initialize_on_precompile = false
    config.active_record.observers = :opportunity_observer, :user_observer, :training_observer

    config.generators do |g|
      g.test_framework :rspec,
                       :fixtures => true,
                       :view_specs => false,
                       :helper_specs => true,
                       :routing_specs => true,
                       :controller_specs => true,
                       :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
    
    #config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
    #  html_tag
    #}
    
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      html = ''
     #html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
     # add nokogiri gem to Gemfile
     #elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
     #elements.each do |e|
    #   if e.node_name.eql? 'label'
    #     html = %(<div class="clearfix error">#{e}</div>).html_safe
    #   elsif e.node_name.eql? 'input'
    #     if instance.error_message.kind_of?(Array)
    #       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
    #     else
    #       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
    #     end
    #   end
    # end
    # html
    #end
    
    elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
    elements.each do |e|
      if e.node_name.eql? 'label'
        html = %(#{e}).html_safe
      elsif e.node_name.eql? 'input'
          html = %(#{e}).html_safe
        end
      end
    html
   end
    
    config.logger = Logger.new(STDOUT)
  end
end
