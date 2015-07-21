#lib/askjarvis/character.rb
require "digest"
require "faraday"
require "json"

module Askjarvis
  class Character
    attr_reader :id, :name, :description

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
    end

    def self.find(id)
      response = Faraday.get("#{Askjarvis::BASE_URL}/characters/#{id}?#{Askjarvis.default_query_params}")
      attributes = JSON.parse(response.body)
      new(attributes["data"]["results"][0])
  	end
  end
end