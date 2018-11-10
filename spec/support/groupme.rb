# frozen_string_literal: true

require 'securerandom'

RSpec.shared_context :with_defined_access_token do
  let(:access_token)     { ENV['GROUPME_ACCESS_TOKEN'] || SecureRandom.base64(30).tr('+', '0') }
  let(:new_access_token) { SecureRandom.base64(30).tr('+', '0') }
end

RSpec.shared_context :with_default_groupme_configuration do
  before do
    GroupMe.configure do |config|
      config.access_token = access_token
    end
  end
end

RSpec.configure do |config|
  config.include_context :with_defined_access_token
end
