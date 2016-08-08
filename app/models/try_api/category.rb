module TryApi
  class Category < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :menu_items, Array

    class << self
      def parse(hash)
        category = self.new
        category.title = hash[:title]
        category.menu_items = []
        hash[:menu_items].each do |menu_item|
          category.menu_items << TryApi::MenuItem.parse(menu_item)
        end
        category
      end
    end
  end
end