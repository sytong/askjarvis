$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'askjarvis'

require 'minitest/autorun'
require 'minitest/stub_const'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.default_cassette_options = {
    :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:ts, :hash, :apikey)]
  }
end
