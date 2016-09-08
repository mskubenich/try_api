module TryApi
  class Parameter < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :type, String
    typesafe_accessor :parameters, Array, default: [], items_type: TryApi::Parameter
    typesafe_accessor :required, Boolean, default: true
    typesafe_accessor :description, String
  end
end