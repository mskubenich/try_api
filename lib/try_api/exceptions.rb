module TryApi
  class ConfigFileNotFound < StandardError

    attr_accessor :message

    def initialize(message)
      @message = message
    end

    def message
      "Configuration file #{ @message } not found."
    end
  end

  class ArgumentError < ArgumentError

    attr_accessor :message

    def initialize(message)
      @message = message
    end

    def message
      "Type not allowed here. #{ @message }"
    end
  end
end