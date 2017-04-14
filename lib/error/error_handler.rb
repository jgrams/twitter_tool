#error module to handle errors universally
# include Error::ErrorHandler in application_controller.rb
# and added lib to the autoload_paths
module Error
  module ErrorHandler
    def self.included(klass)
      klass.class_eval do
        rescue_from StandardError do |error|
          handle_error(:standard_error, 500, error.to_s)
        end
      end
    end

    private
    
    def handle_error(error, status, message)
      json_error = {status: status, error: error, message: message}.as_json
      render json: json_error
    end
  
  end
end
