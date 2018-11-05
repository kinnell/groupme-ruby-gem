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

    before do
      stub_request(:get, 'groups')
    end

    context 'when there is no query params or body data' do
      it 'should work' do
        client.request(:get, 'groups')

        expect(WebMock).to have_requested(:get, "https://api.groupme.com/v3/groups?token=#{ACCESS_TOKEN}")
      end
    end

    context 'when there are query params' do
      it 'should work' do
        client.request(:get, 'groups', query: { per_page: 100 })

        expect(WebMock).to have_requested(:get, "https://api.groupme.com/v3/groups?token=#{ACCESS_TOKEN}&per_page=100")
      end
    end

    context 'when there is body data' do
      it 'should work' do
        client.request(:get, 'groups', body: { name: 'Group' })

        expect(WebMock).to have_requested(:get, "https://api.groupme.com/v3/groups?token=#{ACCESS_TOKEN}").with(body: 'name=Group')
      end
    end

    context 'when there are both query params & body data' do
      it 'should work' do
        client.request(:get, 'groups', query: { per_page: 100 }, body: { name: 'Group' })

        expect(WebMock).to have_requested(:get, "https://api.groupme.com/v3/groups?token=#{ACCESS_TOKEN}&per_page=100").with(body: 'name=Group')
      end
    end
  end
end
