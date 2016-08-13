module TryApi
  class SecondLevelMenuItem < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :parameters, Array
    typesafe_accessor :headers, Array

    class << self
      def parse(hash)
        return nil if hash.blank?
        second_level_menu_item = self.new
        second_level_menu_item.title = hash[:title]
        second_level_menu_item.parameters = hash[:parameters]
        second_level_menu_item.headers = hash[:headers]
        second_level_menu_item
      end
    end
  end
end