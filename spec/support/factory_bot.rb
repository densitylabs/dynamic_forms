require 'factory_bot_rails'

FactoryBot.definition_file_paths << File.expand_path('../../factories', __FILE__)

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
