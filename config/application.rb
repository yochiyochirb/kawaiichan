require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kawaiichan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "Tokyo"

    # SanitizeHelper configuration
    config.action_view.sanitized_allowed_tags = %w(strong em b i p code pre tt samp kbd var sub
                                                   sup dfn cite big small address hr br div span
                                                   h1 h2 h3 h4 h5 h6 ul ol li dl dt dd abbr
                                                   acronym a img blockquote del ins) + \
                                                %w(table thead tbody tr th td tbody tfoot) # added to the default
    config.action_view.sanitized_allowed_attributes = %w(href src width height alt cite datetime
                                                         title class name xml:lang abbr)
  end
end
