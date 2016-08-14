module TryApi
  class MenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :html, String
    typesafe_accessor :html_template, String
    typesafe_accessor :description, String
    typesafe_accessor :second_level_menu_items, Array
    typesafe_accessor :project, TryApi::Project

    class << self
      def parse(hash:, project:)
        instance = self.new
        instance.project = project
        instance.title = hash[:title]
        instance.html = hash[:html]
        instance.description = hash[:description]
        instance.second_level_menu_items = []
        unless hash[:second_level_menu_items].blank?
          hash[:second_level_menu_items].each do |second_level_meny_item|
            instance.second_level_menu_items << TryApi::SecondLevelMenuItem.parse(project: instance.project, hash: second_level_meny_item)
          end
        end
        instance
      end
    end
  end
end