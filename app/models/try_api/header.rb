module TryApi
  class Header < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :description, String
    typesafe_accessor :global, Boolean, false

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:name]
        instance.global = hash[:global]
        instance.description = hash[:description]
        instance
      end
    end
  end
end