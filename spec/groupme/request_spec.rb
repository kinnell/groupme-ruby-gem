# frozen_string_literal: true

RSpec.describe GroupMe::Request do
  include_context :groupme_configured_with_access_token
  let(:access_token) { GroupMe.configuration.access_token }

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
        expect(request.opts).to eq({})
      end
    end

    context 'when method is not :get, :post, or :delete' do
      it 'should raise an error' do
        expect { GroupMe::Request.new(:patch) }.to raise_error(GroupMe::UnacceptableRequestMethodError)
      end
    end
  end

  describe '#send' do
    let(:request) { GroupMe::Request.new(:get, 'groups') }

    it 'should not return an error' do
      VCR.use_cassette(request.path) do
        expect { request.send }.not_to raise_error
      end
    end

    it 'should be get back a GroupMe::Response object' do
      VCR.use_cassette(request.path) do
        response = request.send
        expect(response).to be_an_instance_of(GroupMe::Response)
      end
    end
  end

  describe '#method' do
    let(:request) { GroupMe::Request.new(:get, 'groups', per_page: 100) }

    it 'should be able to retrieve the method' do
      expect(request.method).to eq(:get)
    end
  end

  describe '#path' do
    let(:request) { GroupMe::Request.new(:get, 'groups', per_page: 100) }

    it 'should be able to retrieve the path' do
      expect(request.path).to eq('groups')
    end
  end

  describe '#opts' do
    let(:request) { GroupMe::Request.new(:get, 'groups', per_page: 100) }

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

  describe '#full_opts' do
    let(:request) { GroupMe::Request.new(:get, 'groups', opts) }

    context 'when opts are not initially set' do
      let(:opts) { {} }

      it 'should return just the token' do
        expect(request.full_opts).to eq({ token: access_token })
      end
    end

    context 'when opts are initially set' do
      let(:opts) { { per_page: 100 } }

      it 'should return opts & token' do
        expect(request.full_opts).to eq({ token: access_token, per_page: 100 })
      end
    end

    context 'when one of the opts is a new token' do
      let(:new_access_token) { SecureRandom.base64(30) }
      let(:opts) { { token: new_access_token, per_page: 100 } }

      it 'should return opts & only the new token' do
        expect(request.full_opts).to eq({ token: new_access_token, per_page: 100 })
      end
    end
  end

  describe '#token' do
    context 'no token is specified in opts' do
      let(:request)  { GroupMe::Request.new(:get, 'groups') }

      it 'should use the configured token' do
        expect(request.token).to eq(access_token)
      end
    end

    context 'a different token is specified in opts' do
      let(:new_access_token) { SecureRandom.base64(30) }
      let(:request)  { GroupMe::Request.new(:get, 'groups', token: new_access_token) }

      it 'should use the new token' do
        expect(request.token).to eq(new_access_token)
      end
    end
  end
end
