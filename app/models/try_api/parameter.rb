module TryApi
  class Parameter < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :type, String
    typesafe_accessor :description, String

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:name]
        instance.type = hash[:type]
        instance.description = hash[:description]
        instance
      end
    end
  end
end