# frozen_string_literal: true

RSpec.describe GroupMe::Response do
  let(:request)  { GroupMe::Request.new(:get, 'groups') }
  let(:response) { request.send! }

  describe '#new' do
    it 'should initialize a GroupMe::Response object' do
      expect(response).to be_an_instance_of(GroupMe::Response)
    end
  end

  describe '.raw' do
    it 'should return an HTTP::Response object' do
      expect(response.raw).to be_an_instance_of(HTTP::Response)
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
      let(:request)  { GroupMe::Request.new(:get, 'groups') }

      it 'should parse the JSON response into an Array' do
        expect(response_body).to be_an_instance_of(Array)
      end

      it 'should symbolize names' do
        keys = response_body.first.keys

        expect(keys.all? { |k| k.is_a? Symbol }).to eq(true)
      end
    end

    context 'when response will be an hash' do
      let(:request)  { GroupMe::Request.new(:get, 'groups/1234567890') }

      it 'should parse the JSON response into an Hash' do
        expect(response_body).to be_an_instance_of(Hash)
      end

      it 'should symbolize names' do
        expect(response_body.keys.all? { |k| k.is_a? Symbol }).to eq(true)
      end

      it 'should not have the key "response"' do
        expect(response_body.has_key?(:response)).to eq(false)
      end

      it 'should not have the key "meta"' do
        expect(response_body.has_key?(:meta)).to eq(false)
      end
    end
  end
end
