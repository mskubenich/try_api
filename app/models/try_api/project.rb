module TryApi
  class Project < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :menu_items, Array, items_type: TryApi::MenuItem
    typesafe_accessor :protocol, String
    typesafe_accessor :host, String
    typesafe_accessor :port, Integer
    typesafe_accessor :api_prefix, String
    typesafe_accessor :variables, Hash, {}

    def to_json
      super.merge endpoint: endpoint
    end

    def endpoint
      "#{ host }#{ port.blank? ? '' : (':' + port.to_s) }"
    end
  end
end