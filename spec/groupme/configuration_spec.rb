# frozen_string_literal: true

RSpec.describe GroupMe::Configuration do
  after(:each) { GroupMe.reset! }

  context 'when access token is not set' do
    it 'should not raise an error' do
      expect { GroupMe.configuration.access_token }.not_to raise_error
    end

    it 'should return nil' do
      expect(GroupMe.configuration.access_token).to eq(nil)
    end
  end

  context 'when access token is set' do
    let(:access_token) { SecureRandom.base64(30) }

    before do
      GroupMe.configure { |config| config.access_token = access_token }
    end

    it 'should return it' do
      expect(GroupMe.configuration.access_token).to eq(access_token)
    end
  end
end
