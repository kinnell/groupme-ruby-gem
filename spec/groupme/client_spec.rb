# frozen_string_literal: true

RSpec.describe GroupMe::Client do
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
    let(:client) { GroupMe::Client.new(access_token: ACCESS_TOKEN) }
    let(:base_url) { 'https://api.groupme.com/v3/' }

    before do
      stub_request(:get, 'groups')
      stub_request(:post, 'groups')
    end

    context 'when there are no parameters' do
      it 'should work' do
        client.request(:get, 'groups')

        expect(WebMock).to have_requested(:get, "#{base_url}groups?token=#{ACCESS_TOKEN}")
      end
    end

    context 'when there are query parameters' do
      it 'should work' do
        client.request(:get, 'groups', query: { per_page: 100 })

        expect(WebMock).to have_requested(:get, "#{base_url}groups?token=#{ACCESS_TOKEN}&per_page=100")
      end
    end

    context 'when there are body parameters' do
      it 'should work' do
        client.request(:post, 'groups', body: { name: 'Group' })

        expect(WebMock).to have_requested(:post, "#{base_url}groups?token=#{ACCESS_TOKEN}").with(body: 'name=Group')
      end
    end
  end
end
