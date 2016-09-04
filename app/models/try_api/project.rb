module TryApi
  class Project < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :menu_items, Array
    typesafe_accessor :host, String
    typesafe_accessor :port, Integer
    typesafe_accessor :api_prefix, String
    typesafe_accessor :variables, Hash, {}

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:project_name]
        instance.host = hash[:host]
        instance.port = hash[:port]
        instance.api_prefix = hash[:api_prefix]
        instance.variables = hash[:variables]
        instance.menu_items = []
        hash[:menu_items].each do |category|
          instance.menu_items << TryApi::MenuItem.parse(hash: category, project: instance)
        end
        instance
      end
    end

    def to_json
      super.merge endpoint: endpoint
    end

    def endpoint
      "#{ host }#{ port.blank? ? '' : (':' + port.to_s) }"
    end
  end
end