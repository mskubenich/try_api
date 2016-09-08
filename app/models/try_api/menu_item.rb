module TryApi
  class MenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :html_template, String
    typesafe_accessor :description, String
    typesafe_accessor :methods, Array, items_type: TryApi::Method
  end
end