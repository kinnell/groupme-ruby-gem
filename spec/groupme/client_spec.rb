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
    let(:sample_data) { { id: 1, name: 'Group' } }
    let(:response_body) { { response: sample_data }.to_json }
    let(:response_status) { 200 }

    before do
      stub_request(:any, /api.groupme.com/).to_return(
        body: response_body,
        status: response_status
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

        expect(WebMock).to have_requested(:post, "#{base_url}groups?token=#{ACCESS_TOKEN}").with(body: 'name=Group')
      end
    end

    context 'when response is successful' do
      it 'should parse and return the response' do
        response = client.request(:post, 'groups')

        expect(response).to eq(sample_data)
      end
    end

    context 'when response is not successful' do
      let(:response_body) { 'Not Found' }
      let(:response_status) { 404 }

      it 'should return nil' do
        response = client.request(:post, 'groups')

        expect(response).to be_nil
      end
    end
  end

  describe '#get' do
    let(:sample_data) { { id: 1, name: 'Group' } }

    before do
      stub_request(:get, /api.groupme.com/).to_return(
        body: { response: sample_data }.to_json,
        status: 200
      )
    end

    it 'should parse and return the response' do
      response = client.get('groups', per_page: 1)

      expect(response).to eq(sample_data)
    end
  end

  describe '#post' do
    let(:sample_data) { { id: 1, name: 'Group' } }

    before do
      stub_request(:post, /api.groupme.com/).to_return(
        body: { response: sample_data }.to_json,
        status: 200
      )
    end

    it 'should parse and return the response' do
      response = client.post('groups', name: 'Group')

      expect(response).to eq(sample_data)
    end
  end

  describe '#delete' do
    let(:sample_data) { 'OK' }

    before do
      stub_request(:delete, /api.groupme.com/).to_return(
        body: { response: sample_data }.to_json,
        status: 200
      )
    end

    it 'should parse and return the response' do
      response = client.delete('groups', id: 1)

      expect(response).to eq(sample_data)
    end
  end
end
