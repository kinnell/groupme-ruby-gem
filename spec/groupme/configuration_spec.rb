# frozen_string_literal: true

RSpec.describe GroupMe::Configuration do
  before(:each) { GroupMe.reset! }

  it 'should return nil if an access_token is not set' do
    expect(GroupMe.configuration.access_token).to eq(nil)
  end

  it 'should be able to set and retrieve a configured access token' do
    sample_access_token = 'R3EypXu5HbiA1Gcq4RpBIV7ws8kxmwb1pFpCqHxY'
    GroupMe.configure { |config| config.access_token = sample_access_token }

    expect(GroupMe.configuration.access_token).to eq(sample_access_token)
  end
end
