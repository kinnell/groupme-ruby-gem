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

      it 'should have an empty Hash as opts' do
        expect(request.opts).to eq(Hash.new)
      end
    end

    context 'when method is not :get, :post, or :delete' do
      it 'should raise an error' do
        expect { GroupMe::Request.new(:patch) }.to raise_error(GroupMe::UnacceptableRequestMethodError)
      end
    end
  end

  describe '#method' do
    let(:request) { GroupMe::Request.new(:delete, 'groups', per_page: 100) }

    it 'should be able to retrieve the method' do
      expect(request.method).to eq(:delete)
    end
  end

  describe '#path' do
    let(:request) { GroupMe::Request.new(:delete, 'groups', per_page: 100) }

    it 'should be able to retrieve the path' do
      expect(request.path).to eq('groups')
    end
  end

  describe '#opts' do
    let(:request) { GroupMe::Request.new(:delete, 'groups', per_page: 100) }

    it 'should be able to retrieve the opts' do
      expect(request.opts).to eq({ per_page: 100 })
    end
  end

  describe '#full_uri' do
    let(:request)  { GroupMe::Request.new(:get, 'groups') }
    let(:base_uri) { GroupMe::Request::API_BASE_URI }

    it 'should be able to build & return a full uri' do
      expect(request.full_uri).to eq("#{base_uri}/groups")
    end
  end

  describe '#token' do
    context 'no token is specified in opts' do
      let(:request)  { GroupMe::Request.new(:get, 'groups') }

      it 'should use the configured token' do
        expect(request.token).to eq(random_access_token)
      end
    end

    context 'a different token is specified in opts' do
      let(:new_access_token) { 'LVCxsDxUsYFJuGRLNYbrkcufvavJZEgzRQkkUOUt' }
      let(:request)  { GroupMe::Request.new(:get, 'groups', token: new_access_token) }

      it 'should use the new token' do
        expect(request.token).to eq(new_access_token)
      end
    end
  end
end
