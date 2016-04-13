DigitalServicesCore::Enrollment.class_eval do

  self.table_name = "enrollments"

  belongs_to :grid_reference, class_name: "GridReference"
  accepts_nested_attributes_for :grid_reference

  has_many :enrollment_exemptions, foreign_key: :enrollment_id,
           dependent: :restrict_with_exception
  accepts_nested_attributes_for :enrollment_exemptions

  has_many :exemptions, through: :enrollment_exemptions, dependent: :restrict_with_exception
  accepts_nested_attributes_for :exemptions

  # The Details/Contact info for the Business/Org applying for Exemption
  belongs_to :organisation, inverse_of: :enrollment, class_name: "DigitalServicesCore::Organisation"
  accepts_nested_attributes_for :organisation, update_only: true
end
