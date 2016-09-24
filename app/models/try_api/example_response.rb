module TryApi
  class ExampleResponse < TryApi::Base
    typesafe_accessor :code, Integer
    typesafe_accessor :response, String
    typesafe_accessor :type, String

    class << self
      def parse(hash:, project:)
        return nil if hash.blank?
        instance = self.new
        instance.code = hash[:code]
        instance.project = project
        instance.response = hash[:response]
        instance.type = hash[:type]
        instance
      end

      def descriptions
        {
            200 => :success,
            201 => :created,
            204 => :no_content,
            304 => :not_modified,
            400 => :bad_request,
            401 => :unauthorized,
            403 => :forbidden,
            404 => :not_found,
            408 => :request_timeout,
            422 => :unprocessable_entity,
            500 => :internal_server_error,
            502 => :bad_gateway,
            503 => :service_unavailable,
            504 => :gateway_timeout
        }
      end
    end

    def description
      self.class.descriptions[self.code].to_s.humanize
    end

    def color
      case self.code
        when 200
          'success'
        when 200...300
          'info'
        when 300...400
          'warning'
        when 400...500
          'warning'
        when 500
          'danger'
        else
          'default'
      end
    end

    def to_json(id)
      super(id).merge color: color, description: description, isCollapsed: true
    end
  end
end