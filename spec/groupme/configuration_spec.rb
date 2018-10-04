# frozen_string_literal: true

RSpec.describe GroupMe::Configuration do
  after(:each) { GroupMe.reset! }

  context 'when access token is not set' do
    it 'should return nil' do
      expect(GroupMe.configuration.access_token).to eq(nil)
    end
  end

  context 'when access token is set' do
    let(:sample_access_token) { 'R3EypXu5HbiA1Gcq4RpBIV7ws8kxmwb1pFpCqHxY' }

    it 'should be able to set and retrieve it' do
      GroupMe.configure { |config| config.access_token = sample_access_token }

      expect(GroupMe.configuration.access_token).to eq(sample_access_token)
    end
  end
end
