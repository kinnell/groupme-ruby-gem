# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/namespace'

class FakeGroupMe < Sinatra::Base
  register Sinatra::Namespace

  namespace '/v3' do
  end
  private

  def json_response(fixture_path)
    File.open("#{File.dirname(__dir__)}/fixtures/#{fixture_path}.json").read
  end
end
