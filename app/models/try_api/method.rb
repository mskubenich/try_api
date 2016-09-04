module TryApi
  class Method < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :description, String
    typesafe_accessor :parameters, Array
    typesafe_accessor :headers, Array
    typesafe_accessor :path, String
    typesafe_accessor :method, String
    typesafe_accessor :example_responses, Array
    typesafe_accessor :project, TryApi::Project

    class << self
      def parse(hash:, project:)
        return nil if hash.blank?
        instance = self.new
        instance.project = project
        instance.title = hash[:title]
        instance.description = hash[:description]
        instance.parameters = hash[:parameters]
        instance.headers = hash[:headers]
        instance.method = hash[:method].try(:upcase)
        instance.path = hash[:path]

        instance.example_responses = []
        if hash[:example_responses].is_a? Array
          hash[:example_responses].each do |example|
            instance.example_responses << TryApi::ExampleResponse.parse(hash: example, project: project)
          end
        else
        #   TODO raise exception ?
        end

        instance.parameters = []
        if hash[:parameters].is_a? Array
          hash[:parameters].each do |parameter|
            instance.parameters << TryApi::Parameter.parse(parameter)
          end
        else
        #   TODO raise exception ?
        end

        instance.headers = []
        if hash[:headers].is_a? Array
          hash[:headers].each do |header|
            instance.headers << TryApi::Header.parse(header)
          end
        else
        #   TODO raise exception ?
        end
        instance
      end
    end

    def to_json
      super.merge local_path: local_path, full_path: full_path
    end

    def full_path
      "#{ project.host }:#{ project.port }/#{ project.api_prefix }#{ self.path }"
    end

    def local_path
      "/#{ project.api_prefix }#{ self.path }"
    end
  end
end