module TryApi
  class Project < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :categories, Array
    typesafe_accessor :host, String
    typesafe_accessor :port, Integer
    typesafe_accessor :api_prefix, String

    class << self
      def parse(hash)
        project = self.new
        project.name = hash[:project_name]
        project.host = hash[:host]
        project.port = hash[:port]
        project.api_prefix = hash[:api_prefix]
        project.categories = []
        hash[:categories].each do |category|
          project.categories << TryApi::Category.parse(category)
        end
        project
      end
    end

    def endpoint
      [host, port].flatten.join(':')
    end
  end
end