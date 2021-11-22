# frozen_string_literal: true

module GroupMe
  class Configuration
    API_MAX_GROUPS_PER_PAGE = 500

    attr_writer :access_token, :groups_per_page

    def access_token
      raise MissingConfigurationError unless @access_token

      @access_token
    end

    def groups_per_page
      @groups_per_page ||= API_MAX_GROUPS_PER_PAGE
    end
  end

  def self.configure
    yield(configuration)
  end

  def self.reset_configuration!
    @configuration = Configuration.new
  end

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
