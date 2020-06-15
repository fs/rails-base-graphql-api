class ValidateActivitiesEventColumnNotNull < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      execute 'ALTER TABLE "activities" VALIDATE CONSTRAINT "activities_event_null"'
    end

    change_column_null :activities, :event, false
    safety_assured do
      execute 'ALTER TABLE "activities" DROP CONSTRAINT "activities_event_null"'
    end
  end
end
