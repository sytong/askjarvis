require_relative "askjarvis/version"
require_relative "askjarvis/character"

module Askjarvis

  ENV_MARVEL_API_PRIVATE_KEY = "MARVEL_API_PRIVATE_KEY".freeze
  ENV_MARVEL_API_PUBLIC_KEY = "MARVEL_API_PUBLIC_KEY".freeze

  MISSING_PRIVATE_KEY_ERROR = "Env var MARVEL_API_PRIVATE_KEY is undefined".freeze
  MISSING_PUBLIC_KEY_ERROR = "Env var MARVEL_API_PUBLIC_KEY is undefined".freeze

  BASE_URL = "http://gateway.marvel.com/v1/public".freeze

  # Return the Marvel API default query parameters as a string
  #
  # @raise [AskjarvisError] if environment variable MARVEL_API_PRIVATE_KEY is not defined
  # @raise [AskjarvisError] if environment variable MARVEL_API_PUBLIC_KEY is not defined
  # @return [String] default query parameters including timestamp, hash and public key
  def self.default_query_params
    raise AskjarvisError.new(MISSING_PRIVATE_KEY_ERROR) if ENV[ENV_MARVEL_API_PRIVATE_KEY].nil?
    raise AskjarvisError.new(MISSING_PUBLIC_KEY_ERROR) if ENV[ENV_MARVEL_API_PUBLIC_KEY].nil?

    private_key = ENV[ENV_MARVEL_API_PRIVATE_KEY]
    public_key = ENV[ENV_MARVEL_API_PUBLIC_KEY]
    ts = Time.now.to_i.to_s
    hash = Digest::MD5.hexdigest("#{ts}#{private_key}#{public_key}")
    "ts=#{ts}&apikey=#{public_key}&hash=#{hash}"
  end

  # `AskjarvisError` is a general error class for this module
  class AskjarvisError < RuntimeError; end
end
