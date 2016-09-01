module TryApi
  class MenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :html_template, String
    typesafe_accessor :description, String
    typesafe_accessor :methods, Array
    typesafe_accessor :project, TryApi::Project

    class << self
      def parse(hash:, project:)
        instance = self.new
        instance.project = project
        instance.title = hash[:title]
        instance.description = hash[:description]
        instance.methods = []
        unless hash[:methods].blank?
          hash[:methods].each do |second_level_meny_item|
            instance.methods << TryApi::Method.parse(project: instance.project, hash: second_level_meny_item)
          end
        end
        instance
      end
    end
  end
end