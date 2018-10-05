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
end
