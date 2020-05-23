# frozen_string_literal: true

RSpec.describe GroupMe::Group do
  include_context :with_default_groupme_configuration

  describe '.all' do
    it 'should send the correct HTTP request' do
      _groups = GroupMe::Group.all

      expect(WebMock).to have_requested(:get, 'https://api.groupme.com/v3/groups').with(query: { token: access_token, omit: :memberships, per_page: GroupMe.configuration.groups_per_page })
    end
  end
end
