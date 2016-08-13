module TryApi
  class MenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :html, String
    typesafe_accessor :html_template, String
    typesafe_accessor :description, String
    typesafe_accessor :second_level_menu_items, Array

    class << self
      def parse(hash)
        menu_item = self.new
        menu_item.title = hash[:title]
        menu_item.html = hash[:html]
        menu_item.description = hash[:description]
        menu_item.second_level_menu_items = []
        unless hash[:second_level_menu_items].blank?
          hash[:second_level_menu_items].each do |second_level_meny_item|
            menu_item.second_level_menu_items << TryApi::SecondLevelMenuItem.parse(second_level_meny_item)
          end
        end
        menu_item
      end
    end
  end
end