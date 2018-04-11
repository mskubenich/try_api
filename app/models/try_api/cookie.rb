module TryApi
  class Cookie < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :description, String
    typesafe_accessor :global, [TrueClass, FalseClass], default: false
  end
end