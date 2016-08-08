module TryApi
  class MenuItem
    attr_accessor :title
    attr_accessor :description

    class << self
      def parse(hash)
        menu_item = self.new
        menu_item.title = hash[:title]
        menu_item.description = hash[:description]
        menu_item
      end
    end
  end
end