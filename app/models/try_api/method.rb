module TryApi
  class Method < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :description, String
    typesafe_accessor :parameters, Array, items_type: TryApi::Parameter
    typesafe_accessor :headers, Array, items_type: TryApi::Header
    typesafe_accessor :path, String
    typesafe_accessor :method, String
    typesafe_accessor :example_responses, Array, items_type: TryApi::ExampleResponse

    def to_json
      super.merge local_path: local_path, full_path: full_path
    end

    def full_path
      "#{ project.host }:#{ project.port }/#{ project.api_prefix }#{ self.path }"
    end

    def local_path
      "/#{ self.project.api_prefix }#{ self.path }"
    end
  end
end