# frozen_string_literal: true

module GroupMe
  class ImageClient
    API_BASE_URL = 'https://image.groupme.com/'

    attr_accessor :access_token

    def initialize(args = {})
      @access_token = args[:access_token] || GroupMe.configuration.access_token
      @client = HTTPClient.new(base_url: API_BASE_URL, default_header: { 'X-Access-Token': @access_token, 'Content-Type': 'image/jpeg' })
    end

    def upload(body = {})
      response = @client.post('pictures', body&.to_json)\

      return response.reason unless response.ok?

      image = JSON.parse(response.body, symbolize_names: true)
      image[:payload][:url]
    end
  end
end
