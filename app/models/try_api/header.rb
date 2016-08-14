module TryApi
  class Header < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :description, String

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:name]
        instance.description = hash[:description]
        instance
      end
    end
  end
end