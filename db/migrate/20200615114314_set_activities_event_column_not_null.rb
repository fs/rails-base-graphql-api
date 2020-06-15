class SetActivitiesEventColumnNotNull < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      execute 'ALTER TABLE "activities" ADD CONSTRAINT "activities_event_null" CHECK ("event" IS NOT NULL) NOT VALID'
    end
  end
end
