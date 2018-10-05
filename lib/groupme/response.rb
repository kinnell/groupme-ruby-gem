# frozen_string_literal: true

module GroupMe
  class Response
    def initialize(response)
      @response = response
    end

    def raw
      @response
    end

    def code
      @response.code
    end

    def body
      JSON.parse(@response.body, symbolize_names: true).fetch(:response)
    end
  end
end
