# error module to handle errors universally
# include Error::ErrorHandler in application_controller.rb
# and added lib to the autoload_paths
# taken mostly from guide here: https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b
module Error
  module ErrorHandler
    def self.included(klass)
      binding.pry
      klass.class_eval do
        rescue_from StandardError, with: :handle_error
        end
      end
    end

    private
    
    def handle_error(error)
      @error = {status: 404, error: error, message: error.e.to_s}
      binding.pry
      render json: @error, status: 404
    end
  
  end
end
