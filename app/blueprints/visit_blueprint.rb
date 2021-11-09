class VisitBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_id, :date, :time, :visitor_name, :user_id, :is_video, :note
end
