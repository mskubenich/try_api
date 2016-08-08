module TryApi
  class ConfigFileNotFound < StandardError
    def message
      "Configuration file config/try_api.yml not found. Run 'rails generate try_api:install' to generate it."
    end
  end
  class ArgumentError < ArgumentError
    def message
      "Type not allowed here."
    end
  end
end