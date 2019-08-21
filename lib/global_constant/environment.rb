module GlobalConstant

  class Environment

    class << self
      def production_environment
        'production'
      end

      def is_production?
        GlobalConstant::Base.environment_name == GlobalConstant::Environment.production_environment
      end

    end

  end

end