# frozen_string_literal: true

module GroupMe
  module Core
    extend self

    def root
      Pathname.new(__dir__)
    end
  end

  extend Core
end
