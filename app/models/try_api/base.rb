module TryApi
  class Base
    def self.typesafe_accessor(name, type)

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        if value.is_a? type
          instance_variable_set("@#{name}", value)
        else
          raise TryApi::ArgumentError.new
        end
      end
    end
  end
end