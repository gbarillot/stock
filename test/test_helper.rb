ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest'
require 'rails/test_help'
require 'minitest/spec'
require 'minitest/matchers'
require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'minitest/reporters'
require 'valid_attribute'
require 'capybara/rails'
require 'minitest-metadata'
require 'rack/test'
require 'json_expressions/minitest'
#require 'webmock_stubs'
#require 'webmock/minitest'
require 'vcr'

include ActionDispatch::TestProcess
include Warden::Test::Helpers
include ERB::Util
include ValidAttribute::Method

Rails.logger.level = 4
Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

Minitest::Reporters.use!(
    Minitest::Reporters::DefaultReporter.new,
    ENV,
    Minitest.backtrace_filter
)

# Forces all threads to share the same connection (usefull for Capybara)
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

class Minitest::Test
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def response
    last_response
  end

  def response_json
    @json ||= jsonify(response.body)
  end

  def post_json(uri, params = {}, env = {}, &block)
    post(uri, params.to_json, env.merge!({'CONTENT_TYPE' => 'application/json'}), &block)
  end

  def url_helper
    Rails.application.routes.url_helpers
  end
end

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  # Performance: order tests by time taken
  #include Minitest::Profiler
  ActiveRecord::Migration.check_pending!
  WebMock.disable_net_connect!(allow_localhost: true)

  fixtures :all
  self.use_transactional_tests = true
  self.pre_loaded_fixtures = true

  register_spec_type(self) do |desc|
    desc < ActiveRecord::Base if desc.is_a?(Class)
  end

  # Allow context to be used like describe
  class << self
    alias :context :describe
  end

  def setup
    I18n.locale = I18n.default_locale
    $current_user = users(:employee)
  end

  def teardown
    Warden.test_reset!
  end

  def reload_records(*records)
    records.each(&:reload)
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "#{Rails.root}/test/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.register_request_matcher :body_regexp do |request_1, request_2|
    !!((Regexp.new request_2.body) =~ request_1.body)
  end
  config.default_cassette_options = {
    record: :none, allow_playback_repeats: true
  }
end
