#lib/askjarvis/character.rb
require "digest"
require "faraday"
require "json"

BASE_URL = "http://gateway.marvel.com/v1/public"
PRIVATE_KEY = ENV["MARVEL_API_PRIVATE_KEY"]
PUBLIC_KEY = ENV["MARVEL_API_PUBLIC_KEY"]
TIMESTAMP = Time.now.to_i.to_s
URL_HASH = Digest::MD5.hexdigest("#{TIMESTAMP}#{PRIVATE_KEY}#{PUBLIC_KEY}")
DEFAULT_PARAMS = "ts=#{TIMESTAMP}&apikey=#{PUBLIC_KEY}&hash=#{URL_HASH}"

module Askjarvis
  class Character
  	attr_reader :id, :name, :description

  	def initialize(attributes)
  		@id = attributes["id"]
  		@name = attributes["name"]
  	end

  	def self.find(id)
      response = Faraday.get("#{BASE_URL}/characters/#{id}?#{DEFAULT_PARAMS}")
      attributes = JSON.parse(response.body)
      new(attributes["data"]["results"][0])
  	end
  end
end