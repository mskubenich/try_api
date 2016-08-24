module TryApi
  class Category < TryApi::Base
    typesafe_accessor :title, String
    typesafe_accessor :visible, Boolean, default: true
    typesafe_accessor :menu_items, Array
    typesafe_accessor :project, TryApi::Project

    class << self
      def parse(hash:, project:)
        instance = self.new
        instance.title = hash[:title]
        instance.visible = hash[:visible]
        instance.project = project
        instance.menu_items = []
        hash[:menu_items].each do |menu_item|
          instance.menu_items << TryApi::MenuItem.parse(hash: menu_item, project: instance.project)
        end
        instance
      end
    end
  end
end