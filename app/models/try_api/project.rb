module TryApi
  class Project < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :categories, Array
    typesafe_accessor :host, String
    typesafe_accessor :port, Integer
    typesafe_accessor :api_prefix, String

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:project_name]
        instance.host = hash[:host]
        instance.port = hash[:port]
        instance.api_prefix = hash[:api_prefix]
        instance.categories = []
        hash[:categories].each do |category|
          instance.categories << TryApi::Category.parse(hash: category, project: instance)
        end
        instance
      end
    end

    def endpoint
      "#{ host}#{ port.blank? ? '' : (':' + port) }"
    end
  end
end