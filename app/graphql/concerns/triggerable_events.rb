module TriggerableEvents
  extend ActiveSupport::Concern

  private

  def append_trigger_event(trigger_event)
    context[:trigger_events] ||= []
    context[:trigger_events] << trigger_event
  end
end
