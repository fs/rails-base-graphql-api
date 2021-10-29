# Default scale factors to use.
# We use the smallest possible but representative scale factors by default.
NPlusOneControl.default_scale_factors = [2, 3]

# Print performed queries if true in the case of failure
# You can activate verbosity through env variable NPLUSONE_VERBOSE=1
NPlusOneControl.verbose = false

# Print table hits difference, for example:
#
#   Unmatched query numbers by tables:
#     users (SELECT): 2 != 3
#     events (INSERT): 1 != 2
#
NPlusOneControl.show_table_stats = true

# Ignore matching queries
NPlusOneControl.ignore = /^(BEGIN|COMMIT|SAVEPOINT|RELEASE)/

# ActiveSupport notifications event to track queries.
# We track ActiveRecord event by default,
# but can also track rom-rb events ('sql.rom') as well.
NPlusOneControl.event = "sql.active_record"

# configure transactional behavour for populate method
# in case of use multiple database connections
NPlusOneControl::Executor.tap do |executor|
  connections = ActiveRecord::Base.connection_handler.connection_pool_list.map(&:connection)

  executor.transaction_begin = -> do
    connections.each { |connection| connection.begin_transaction(joinable: false) }
  end
  executor.transaction_rollback = -> do
    connections.each(&:rollback_transaction)
  end
end

# Provide a backtrace cleaner callable object used to filter SQL caller location to display in the verbose mode
# Set it to nil to disable tracing.
#
# In Rails apps, we use Rails.backtrace_cleaner by default.
# NPlusOneControl.backtrace_cleaner = ->(locations_array) { do_some_filtering(locations_array) }

# You can also specify the number of backtrace lines to show.
# MOTE: It could be specified via NPLUSONE_BACKTRACE env var
NPlusOneControl.backtrace_length = 1

# Sometime queries could be too large to provide any meaningful insight.
# You can configure an output length limit for quries in verbose mode by setting the follwing option
# NOTE: It could be specified via NPLUSONE_TRUNCATE env var
NPlusOneControl.truncate_query_size = 100
