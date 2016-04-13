DigitalServicesCore::Enrollment.class_eval do

  self.table_name = "enrollments"

  belongs_to :grid_reference, class_name: "FloodRiskEngine::Location"
  accepts_nested_attributes_for :grid_reference


  # We don't define the inverse relationship of applicant_contact as, in WEX at least,
  # we query never from contact to its enrollment
  belongs_to :applicant_contact, class_name: "FloodRiskEngine::Contact"
  belongs_to :organisation, class_name: "FloodRiskEngine::Organisation"
  belongs_to :site_address, class_name: "FloodRiskEngine::Address"

  has_many :enrollment_exemptions, foreign_key: :enrollment_id,
           dependent: :restrict_with_exception, class_name: "FloodRiskEngine::EnrollmentExemption"

  has_many :exemptions, through: :enrollment_exemptions,
           dependent: :restrict_with_exception, class_name: "FloodRiskEngine::Exemption"

end
