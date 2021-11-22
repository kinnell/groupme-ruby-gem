# frozen_string_literal: true

module GroupMe
  module Core
    def self.root
      Pathname.new(__dir__)
    end
  end

  extend Core
end
