# frozen_string_literal: true

require 'sinatra/base'

class FakeGroupMe < Sinatra::Base
  private

  def json_response(fixture_path)
    File.open("#{File.dirname(__dir__)}/fixtures/#{fixture_path}.json").read
  end
end
