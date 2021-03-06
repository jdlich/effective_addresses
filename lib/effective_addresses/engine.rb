module EffectiveAddresses
  class Engine < ::Rails::Engine
    engine_name 'effective_addresses'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/validators"]

    # Include Helpers to base application
    initializer 'effective_addresses.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper EffectiveAddressesHelper
      end
    end

    # Include acts_as_addressable concern and allow any ActiveRecord object to call it
    initializer 'effective_addresses.active_record' do |app|
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.extend(ActsAsAddressable::ActiveRecord)
      end
    end

    # Set up our default configuration options.
    initializer "effective_addresses.defaults", :before => :load_config_initializers do |app|
      eval File.read("#{config.root}/lib/generators/templates/effective_addresses.rb")
    end

  end
end

