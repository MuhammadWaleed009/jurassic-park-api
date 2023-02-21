class ApplicationController < ActionController::API
  include Pundit::Authorization

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from Pundit::NotAuthorizedError, with: :authorization_error

  protected
  
  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: :not_found
  end
  
  def error_occurred(exception)
    render json: { error: exception.message }.to_json, status: :internal_server_error
  end

  def authorization_error(e)
    render json: { error: 'You do not have the rights to perform this action.' }.to_json, status: :unauthorized
  end
end
