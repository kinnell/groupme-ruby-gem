# frozen_string_literal: true

RSpec.describe GroupMe::Response do
  include_context :groupme_configured_with_access_token

  let(:request)  { GroupMe::Request.new(:get, 'groups') }
  let(:response) { VCR.use_cassette(request.path) { request.send } }

  describe '#new' do
    it 'should initialize a GroupMe::Response object' do
      expect(response).to be_an_instance_of(GroupMe::Response)
    end
  end

  describe '.raw' do
    it 'should return an HTTP::Response object' do
      expect(response.raw).to be_an_instance_of(HTTP::Message)
    end
  end

  describe '.code' do
    let(:actual_code) { response.raw.code }

    it 'should the response status code' do
      expect(response.code).to eq(actual_code)
    end
  end

  describe '.body' do
    let(:response_body) { response.body }

    context 'when response will be an array' do
      let(:request) { GroupMe::Request.new(:get, 'groups') }

      it 'should parse the JSON response into an Array' do
        expect(response_body).to be_an_instance_of(Array)
      end

      it 'should symbolize names' do
        keys = response_body.first.keys

        expect(keys.all? { |k| k.is_a? Symbol }).to eq(true)
      end
    end

    context 'when response will be an hash' do
      let(:request) { GroupMe::Request.new(:get, 'users/me') }

      it 'should parse the JSON response into an Hash' do
        expect(response_body).to be_an_instance_of(Hash)
      end

      it 'should symbolize names' do
        expect(response_body.keys.all? { |k| k.is_a? Symbol }).to eq(true)
      end

      it 'should not have the key "response"' do
        expect(response_body.key?(:response)).to eq(false)
      end

      it 'should not have the key "meta"' do
        expect(response_body.key?(:meta)).to eq(false)
      end
    end
  end
end
