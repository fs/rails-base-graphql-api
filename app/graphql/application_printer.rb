class ApplicationPrinter < GraphQL::Language::Printer
  def print_argument(arg)
    return super if %w(password currentPassword).exclude?(arg.name)

    "#{arg.name}: [FILTERED]"
  end
end
