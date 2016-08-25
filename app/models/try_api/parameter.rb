module TryApi
  class Parameter < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :type, String
    typesafe_accessor :parameters, Array, default: []
    typesafe_accessor :required, Boolean, default: true
    typesafe_accessor :description, String

    class << self
      def parse(hash)
        instance = self.new
        instance.name = hash[:name]
        instance.type = hash[:type]
        instance.required = hash[:required]
        instance.description = hash[:description]

        instance.parameters = []
        if hash[:parameters].is_a? Array
          hash[:parameters].each do |parameter|
            instance.parameters << TryApi::Parameter.parse(parameter)
          end
        else
          #   TODO raise exception ?
        end

        instance
      end
    end
  end
end