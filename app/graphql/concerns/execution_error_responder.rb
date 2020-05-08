module ExecutionErrorResponder
  extend ActiveSupport::Concern

  private

  def execution_error(error_data:)
    GraphQL::ExecutionError.new(
      error_data[:message],
      extensions: execution_error_extensions(error_data)
    )
  end

  def execution_error_extensions(error_data)
    {
      detail: error_data[:detail],
      status: error_data[:status] || 422,
      code: error_data[:code] || :unprocessable_entity
    }
  end
end
