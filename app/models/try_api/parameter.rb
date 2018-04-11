module TryApi
  class Parameter < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :type, String
    typesafe_accessor :parameters, Array, default: [], items_type: TryApi::Parameter
    typesafe_accessor :required, [TrueClass, FalseClass], default: true
    typesafe_accessor :custom, [TrueClass, FalseClass], default: false, if: -> { self.type == 'object' }
    typesafe_accessor :description, String
  end
end