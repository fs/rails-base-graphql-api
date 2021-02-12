class ApplicationPolicy < ActionPolicy::Base
  private

   def owner?
     record.user_id == user.id
   end
end
