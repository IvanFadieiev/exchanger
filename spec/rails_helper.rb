ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'
require 'rspec/rails'
require 'spec_helper'
require 'webmock/rspec'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!(allow_localhost: true)

%w[support].each do |dir|
  Dir["./spec/#{dir}/*.rb"].sort.each { |file| require file }
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before do
    file = File.open('./spec/fixtures/currency_data.csv')
    stub_request(:get, 'http://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?format=csvdata')
      .to_return(status: 200, body: file, headers: {})
  end

  config.include FactoryGirl::Syntax::Methods
end
