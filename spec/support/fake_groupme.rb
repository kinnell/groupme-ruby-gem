# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/namespace'

class FakeGroupMe < Sinatra::Base
  register Sinatra::Namespace

  namespace '/v3' do
    get '/groups' do
      json_response('groups/index', 200)
    end

    get '/groups/:group_id' do
      json_response('groups/show', 200)
    end
  end

  private

  def json_response(fixture_path, status_code = 200)
    "{\"response\":#{json_response_body(fixture_path)},\"meta\":{\"code\":#{status_code}}}"
  end

  def json_response_body(fixture_path)
    File.open("#{File.dirname(__dir__)}/fixtures/#{fixture_path}.json").read
  end
end
