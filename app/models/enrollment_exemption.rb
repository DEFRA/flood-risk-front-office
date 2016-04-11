class EnrollmentExemption < ActiveRecord::Base

  self.table_name = "enrollments_exemptions"

  belongs_to :enrollment,
             class_name: "DigitalServicesCore::Enrollment",
             foreign_key: :enrollment_id

  belongs_to :exemption


end
