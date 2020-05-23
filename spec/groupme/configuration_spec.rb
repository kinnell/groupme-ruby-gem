# frozen_string_literal: true

RSpec.describe GroupMe::Configuration do
  before(:each) { GroupMe.reset! }

  describe '#access_token' do
    context 'when :access_token is not configured' do
      it 'should raise an error' do
        expect { GroupMe.configuration.access_token }.to raise_error(GroupMe::MissingConfigurationError)
      end
    end

    context 'when :access_token is configured' do
      include_context :with_default_groupme_configuration

      it 'should return the access_token' do
        expect(GroupMe.configuration.access_token).to eq(access_token)
      end
    end
  end
end

RSpec.describe GroupMe do
  describe '.configuration' do
    it 'should return a GroupMe::Configuration object' do
      expect(GroupMe.configuration).to be_an_instance_of(GroupMe::Configuration)
    end
  end

  describe '.configuration=' do
    it 'should set a new default configuration' do
      old_configuration = GroupMe.configuration
      new_configuration = GroupMe::Configuration.new
      GroupMe.configuration = new_configuration

      expect(GroupMe.configuration).not_to eq(old_configuration)
      expect(GroupMe.configuration).to eq(new_configuration)
    end
  end

  describe 'configure' do
    it 'should set configuration attributes' do
      GroupMe.configure { |config| config.access_token = access_token }

      expect(GroupMe.configuration.access_token).to eq(access_token)
    end
  end

  describe 'reset!' do
    it 'should reset the configuration' do
      old_configuration = GroupMe.configuration
      GroupMe.reset!

      expect(GroupMe.configuration).not_to eq(old_configuration)
    end
  end
end
