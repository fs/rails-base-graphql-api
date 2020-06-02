class GraphqlController < ApplicationController
  def execute
    render json: execute_query
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def execute_query
    ApplicationSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: execution_context,
      operation_name: params[:operationName]
    )
  end

  def execution_context
    {
      current_user: current_user,
      token: token,
      token_payload: payload
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")

    error = { error: { message: exception.message, backtrace: exception.backtrace }, data: {} }

    render json: error, status: :internal_server_error
  end
end
