# frozen_string_literal: true

RSpec.describe GroupMe::Request do
  let(:random_access_token) { 'R3EypXu5HbiA1Gcq4RpBIV7ws8kxmwb1pFpCqHxY' }

  before do
    GroupMe.configure { |config| config.access_token = random_access_token }
  end

  describe '.new' do
    let(:request) { GroupMe::Request.new(method, path, opts) }

    context 'when no parameters are set' do
      let(:request) { GroupMe::Request.new }

      it 'should use :get as the method' do
        expect(request.method).to eq(:get)
      end

      it 'should use empty path as the path' do
        expect(request.path).to eq('')
      end

      it 'should have the API token as the only opt' do
        expect(request.opts).to eq({ token: random_access_token })
      end
    end

    context 'when method is not :get, :post, or :delete' do
      it 'should raise an error' do
        expect { GroupMe::Request.new(:patch) }.to raise_error(GroupMe::UnacceptableRequestMethodError)
      end
    end

    it 'should be able to generate a full uri' do
      request = GroupMe::Request.new(:get, 'groups')
      base_uri = GroupMe::Request::API_BASE_URI

      expect(request.full_uri).to eq("#{base_uri}/groups")
    end
  end
end
