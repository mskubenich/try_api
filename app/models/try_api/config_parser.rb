module TryApi
  class ConfigParser
    class << self

      def read
        if File.exists?("#{ Rails.root }/config/try_api.yml")
          hash = YAML.load_file("#{ Rails.root }/config/try_api.yml")
          TryApi::Project.parse hash.with_indifferent_access
        else
          raise ConfigFileNotFound
        end
      end

    end
  end
end