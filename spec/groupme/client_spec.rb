# frozen_string_literal: true

RSpec.describe GroupMe::Client do
  let(:client) { GroupMe::Client.new(access_token: ACCESS_TOKEN) }
  let(:base_url) { 'https://api.groupme.com/v3/' }

  describe '.new' do
    context 'when :access_token argument is missing' do
      it 'should raise an error' do
        expect { GroupMe::Client.new }.to raise_error(ArgumentError)
      end
    end

    context 'when :access_token is set' do
      it 'should not raise an error' do
        expect { GroupMe::Client.new(access_token: ACCESS_TOKEN) }.not_to raise_error
      end
    end
  end

  describe '#request' do
    let(:stubbed_data) { { id: 1, name: 'Group' } }
    let(:stubbed_response_body) { { response: stubbed_data }.to_json }
    let(:stubbed_response_status) { 200 }

    before do
      stub_request(:any, /api.groupme.com/).to_return(
        body: stubbed_response_body,
        status: stubbed_response_status
      )
    end

    context 'when there are no parameters' do
      it 'should send the correct HTTP request' do
        client.request(:get, 'groups')

        expect(WebMock).to have_requested(:get, "#{base_url}groups").with(query: { token: ACCESS_TOKEN })
      end
    end

    context 'when there are query parameters' do
      it 'should send the correct HTTP request' do
        client.request(:get, 'groups', query: { per_page: 1 })

        expect(WebMock).to have_requested(:get, "#{base_url}groups").with(query: { token: ACCESS_TOKEN, per_page: 1 })
      end
    end

    context 'when there are body parameters' do
      it 'should send the correct HTTP request' do
        client.request(:post, 'groups', body: { name: 'Group' })

        expect(WebMock).to have_requested(:post, "#{base_url}groups?token=#{ACCESS_TOKEN}").with(body: { name: 'Group' }.to_json)
      end
    end

    context 'when response is successful' do
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

    context 'when response is unsuccessful' do
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
