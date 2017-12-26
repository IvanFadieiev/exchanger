ENV['RAILS_ENV'] ||= 'test'

require 'rspec/rails'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!

%w[support].each do |dir|
  Dir["./spec/#{dir}/*.rb"].sort.each { |file| require file }
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods
end
