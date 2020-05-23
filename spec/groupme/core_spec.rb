# frozen_string_literal: true

RSpec.describe GroupMe::Core do
  describe '.root' do
    it 'should not return nil' do
      expect(GroupMe.root).not_to be(nil)
    end
  end
end
