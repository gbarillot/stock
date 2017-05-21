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
#require 'webmock/minitest'
require 'rack/test'
require 'json_expressions/minitest'
#require 'webmock_stubs'
#require 'sidekiq/testing'
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

module VCR
  class << self
    alias_method 'old_turn_off!', 'turn_off!'
    alias_method 'old_turn_on!', 'turn_on!'

    # add default inserted cassettes here
    # VCR.turn_on!
    @@default_cassette = {
        name: 'default',
        options: {
            allow_playback_repeats: true,
            match_requests_on: [:host, :method, -> (request_1, request_2) do
              host1 = URI(request_1.uri).host
              if  ['api2.appsflyer.com', 'rm.rentalsunited.com', 'netverify.com'].include?(host1)
                true
              elsif ['api.siftscience.com', 'api.mixpanel.com'].include?(host1)
                request_1.uri.include?(request_2.uri)
              elsif host1 == 'pal-test.adyen.com'
                if request_1.uri == request_2.uri
                  if request_1.uri.include?('pal/adapter/httppost')
                    !!((Regexp.new request_2.body) =~ request_1.body)
                  else
                    true
                  end
                end
              else
                request_1.uri == request_2.uri
              end
            end],
        }
    }

    VCR.insert_cassette(@@default_cassette[:name], @@default_cassette[:options])

    def turn_off!(options = {})
      VCR.eject_cassette
      old_turn_off!(options)
    end

    def turn_on!
      old_turn_on!
      VCR.insert_cassette(@@default_cassette[:name], @@default_cassette[:options]) unless VCR.current_cassette
    end
  end
end

class ActiveRecord::Base
  def fixture_dump(args={})
    entity = self
    attributes = entity.attributes
    columns_hash = entity.class.columns_hash
    keys = columns_hash.keys
    exclude = args.fetch(:exclude, [])
    return Hash[(args.fetch(:include, keys) & keys)
                    .select{|key| !exclude.include?(key) && !attributes[key].nil?}
                    .map{|key| [key, columns_hash[key].type_cast_for_database(attributes[key]).to_s]}
    ]
  end
end

class ActiveRecord::Base
  def fixture_dump(args={})
    entity = self
    attributes = entity.attributes
    columns_hash = entity.class.columns_hash
    keys = columns_hash.keys
    exclude = args.fetch(:exclude, [])
    return Hash[(args.fetch(:include, keys) & keys)
      .select{|key| !exclude.include?(key) && !attributes[key].nil?}
      .map{|key| [key, columns_hash[key].type_cast_for_database(attributes[key]).to_s]}
    ]
  end
end
