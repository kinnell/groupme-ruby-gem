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
end
