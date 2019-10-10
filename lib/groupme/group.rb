# frozen_string_literal: true

module GroupMe
  class Group
    def self.all
      GroupMe.client.get('groups', omit: :memberships, per_page: GroupMe.configuration.groups_per_page).first
    end
  end
end
