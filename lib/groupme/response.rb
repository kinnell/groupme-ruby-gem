# frozen_string_literal: true

module GroupMe
  class Response
    def initialize(response)
      @response = response
    end

    def raw
      @response
    end
  end
end
