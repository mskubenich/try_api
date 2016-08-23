module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

module TryApi
  class Base
    def self.typesafe_accessor(name, type, options={})

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        if value.is_a?(type) || value.nil?
          value = options[:default] if value.nil? && !options[:default].nil?
          instance_variable_set("@#{name}", value)
        else
          raise TryApi::ArgumentError.new
        end
      end
    end

    def to_json
      result = {}

      self.instance_variables.each do |i|
        value = self.instance_variable_get(i)
        if value.instance_of?(Array)
          result[i.to_s.gsub('@', '')] = value.map(&:to_json)
        else
          if i == :@project

          else
            result[i.to_s.gsub('@', '')] = value
          end
        end
      end

      result.with_indifferent_access
    end
  end
end