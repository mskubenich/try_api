unless Boolean
  module Boolean; end
  class TrueClass; include Boolean; end
  class FalseClass; include Boolean; end
end

module TryApi
  class Base

    def self.typesafe_accessor(name, type, options={})

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        if value.is_a?(type) || value.nil?
          if options[:items_type].try(:<, TryApi::Base)

            items = []
            if value.is_a? Array
              value.each do |item|
                item = load_inclusion(item[:include!]) if item[:include!].present?

                items << options[:items_type].new({ parent: self }.merge(item))
              end
            end

            instance_variable_set("@#{name}", items)
          else
            value = options[:default] if value.nil? && !options[:default].nil?
            instance_variable_set("@#{name}", value)
          end
        else
          raise TryApi::ArgumentError.new
        end
      end
    end

    attr_accessor :id
    typesafe_accessor :parent, TryApi::Base
    @@instances_count = 0

    def to_json
      result = {}

      self.instance_variables.each do |i|
        value = self.instance_variable_get(i)
        if value.instance_of?(Array)
          result[i.to_s.gsub('@', '')] = value.map(&:to_json)
        else
          if i == :@parent

          else
            result[i.to_s.gsub('@', '')] = value
          end
        end
      end

      result.merge!({id: self.id})
      result.with_indifferent_access
    end

    def project
      self.is_a?(TryApi::Project) ? self : self.parent.try(:project)
    end

    def initialize(hash)
      self.id = @@instances_count += 1
      result_hash = {}
      hash.to_h.each do |k, v|
        if k.to_s == 'include!'
          result_hash.merge! load_inclusion(v)
        else
          result_hash[k] = v
        end
      end

      result_hash.to_h.each do |k, v|
        v = self.project.variables[v.gsub('var:', '')] if v.is_a?(String) && v['var:']
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end

    def self.load_inclusion(filename)
      if File.exists?("#{ Rails.root }/config/try_api/#{ filename }.yml")
        hash = YAML.load_file("#{ Rails.root }/config/try_api/#{ filename }.yml")
        hash.with_indifferent_access
      else
        raise ConfigFileNotFound
      end
    end

    def load_inclusion(filename)
      self.class.load_inclusion filename
    end
  end
end
