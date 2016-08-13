module TryApi
  class SecondLevelMenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :parameters, Array
    typesafe_accessor :headers, Array
    typesafe_accessor :example_responses, Array

    class << self
      def parse(hash)
        return nil if hash.blank?
        instance = self.new
        instance.title = hash[:title]
        instance.parameters = hash[:parameters]
        instance.headers = hash[:headers]
        instance.example_responses = []
        if hash[:example_responses].is_a? Array
          hash[:example_responses].each do |example|
            instance.example_responses << TryApi::ExampleResponse.parse(example)
          end
        else
        #   TODO raise exception ?
        end
        instance
      end
    end
  end
end