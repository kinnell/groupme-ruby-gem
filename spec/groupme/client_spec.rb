# frozen_string_literal: true

RSpec.describe GroupMe::Client do
  include_context :with_default_groupme_configuration

  let(:client) { GroupMe::Client.new(access_token: access_token) }
  let(:base_url) { GroupMe::Client::API_BASE_URL }

  describe '.new' do
    context 'when :access_token is not supplied' do
      let(:client) { GroupMe::Client.new }

      it 'should use configured :access_token' do
        expect(client.access_token).to eq(GroupMe.configuration.access_token)
      end
    end

    context 'when :access_token is supplied' do
      let(:client) { GroupMe::Client.new(access_token: new_access_token) }

      it 'should not use configured :access_token' do
        expect(client.access_token).not_to eq(GroupMe.configuration.access_token)
      end

      it 'should use the supplied :access_token' do
        expect(client.access_token).to eq(new_access_token)
      end
    end
  end

  describe '#request' do
    let(:stubbed_data)            { { id: 1, name: 'Group' } }
    let(:stubbed_response_body)   { { response: stubbed_data }.to_json }
    let(:stubbed_response_status) { 200 }

    before do
      stub_request(:any, /api.groupme.com/).to_return(
        body: stubbed_response_body,
        status: stubbed_response_status
      )
    end

    context 'when no parameters are supplied' do
      it 'should send the correct HTTP request' do
        client.request(:get, 'groups')

        expect(WebMock).to have_requested(:get, "#{base_url}groups").with(query: { token: access_token })
      end
    end

    context 'when query parameters are supplied' do
      it 'should send the correct HTTP request' do
        client.request(:get, 'groups', query: { per_page: 1 })

        expect(WebMock).to have_requested(:get, "#{base_url}groups").with(query: { token: access_token, per_page: 1 })
      end
    end

    context 'when body parameters are supplied' do
      it 'should send the correct HTTP request' do
        client.request(:post, 'groups', body: { name: 'Group' })

        expect(WebMock).to have_requested(:post, "#{base_url}groups?token=#{access_token}").with(body: { name: 'Group' }.to_json)
      end
    end

    context 'when the response is successful' do
      let(:stubbed_response_body) { { response: stubbed_data }.to_json }
      let(:stubbed_response_status) { 201 }

      it 'should parse and return the response' do
        response, _status = client.request(:post, 'groups')

        expect(response).to eq(stubbed_data)
      end

      it 'should return the successful status code' do
        _response, status = client.request(:post, 'groups')

        expect(status).to eq(201)
      end
    end

    context 'when the response is unsuccessful' do
      let(:stubbed_response_body) { '' }
      let(:stubbed_response_status) { [404, 'Not Found'] }

      it 'should return the response reason' do
        response, _status = client.request(:post, 'groups')

        expect(response).to eq('Not Found')
      end

      it 'should return the unsuccesful status code' do
        _response, status = client.request(:post, 'groups')

        expect(status).to eq(404)
      end
    end
  end

  describe '#get' do
    let(:stubbed_data) { { id: 1, name: 'Group' } }
    let(:stubbed_response_code) { 200 }

    before do
      stub_request(:get, /api.groupme.com/).to_return(
        body: { response: stubbed_data }.to_json,
        status: stubbed_response_code
      )
    end

    it 'should parse and return the response' do
      response, _status = client.get('groups', per_page: 1)

      expect(response).to eq(stubbed_data)
    end

    it 'should return the status code' do
      _response, status = client.get('groups', per_page: 1)

      expect(status).to eq(stubbed_response_code)
    end
  end

  describe '#post' do
    let(:stubbed_data) { { id: 1, name: 'Group' } }
    let(:stubbed_response_code) { 200 }

    before do
      stub_request(:post, /api.groupme.com/).to_return(
        body: { response: stubbed_data }.to_json,
        status: stubbed_response_code
      )
    end

    it 'should parse and return the response' do
      response, _status = client.post('groups', name: 'Group')

      expect(response).to eq(stubbed_data)
    end

    it 'should return the status code' do
      _response, status = client.post('groups', name: 'Group')

      expect(status).to eq(stubbed_response_code)
    end
  end

  describe '#delete' do
    let(:stubbed_data) { 'OK' }
    let(:stubbed_response_code) { 200 }

    before do
      stub_request(:delete, /api.groupme.com/).to_return(
        body: { response: stubbed_data }.to_json,
        status: stubbed_response_code
      )
    end

    it 'should parse and return the response' do
      response, _status = client.delete('groups', id: 1)

      expect(response).to eq(stubbed_data)
    end

    it 'should return the status code' do
      _response, status = client.delete('groups', id: 1)

      expect(status).to eq(stubbed_response_code)
    end
  end
end

RSpec.describe GroupMe do
  include_context :with_default_groupme_configuration

  describe '.client' do
    it 'should return a GroupMe::Client object' do
      expect(GroupMe.client).to be_a_instance_of(GroupMe::Client)
    end
  end

  describe '.client=' do
    it 'should set a new default client' do
      old_client = GroupMe.client
      new_client = GroupMe::Client.new(access_token: new_access_token)
      GroupMe.client = new_client

      expect(GroupMe.client).not_to eq(old_client)
      expect(GroupMe.client).to eq(new_client)
    end
  end
end
