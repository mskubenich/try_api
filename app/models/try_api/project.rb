module TryApi
  class Project < TryApi::Base
    typesafe_accessor :name, String
    typesafe_accessor :categories, Array

    class << self
      def parse(hash)
        project = self.new
        project.name = hash[:project_name]
        project.categories = []
        hash[:categories].each do |category|
          project.categories << TryApi::Category.parse(category)
        end
        project
      end
    end
  end
end