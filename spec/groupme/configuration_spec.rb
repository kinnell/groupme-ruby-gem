# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GroupMe::Configuration do
  describe '.configuration' do
    context 'when configuration is not set' do
      it 'should return a Configuration object' do
        expect(GroupMe.configuration).to be_an_instance_of(GroupMe::Configuration)
      end
    end

    context 'when configuration is set' do
      before do
        GroupMe.configure { |config| config.access_token = 'ACCESS_TOKEN' }
      end

      it 'should return a Configuration object' do
        expect(GroupMe.configuration).to be_an_instance_of(GroupMe::Configuration)
      end
    end
  end

  describe '.configuration=' do
    it 'should set a new Configuration' do
      new_configuration = GroupMe::Configuration.new
      GroupMe.configuration = new_configuration

      expect(GroupMe.configuration).to eq(new_configuration)
    end
  end

  describe 'configure' do
    let(:access_token) { SecureRandom.base64(30) }

    it 'should set configuration attributes' do
      GroupMe.configure { |config| config.access_token = access_token }

      expect(GroupMe.configuration.access_token).to eq(access_token)
    end
  end

  describe 'reset!' do
    it 'should replace the Configuration object with a new one' do
      old_configuration = GroupMe.configuration
      GroupMe.reset!

      expect(GroupMe.configuration).not_to eq(old_configuration)
    end
  end

  describe '#access_token' do
    context 'when access_token is not configured' do
      it 'should return nil' do
        expect(GroupMe.configuration.access_token).to eq(nil)
      end
    end

    context 'when access_token is configured' do
      before do
        GroupMe.configure { |config| config.access_token = access_token }
      end

      it 'should return the access_token' do
        expect(GroupMe.configuration.access_token).to eq(access_token)
      end
    end
  end
end
