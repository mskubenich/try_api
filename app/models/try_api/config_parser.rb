module TryApi
  class ConfigParser
    class << self

      def read
        TryApi::Project.new TryApi::Base.load_inclusion(:base)
      end

    end
  end
end