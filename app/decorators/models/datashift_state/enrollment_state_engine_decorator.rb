DatashiftState.journey_plan_class.class_eval do

  class_attribute :journey

  # The Array of transitions to dynamically build back and next events for linear journey

  def self.journey
    @state_transitions ||= [
      :check_location,
      :add_exemptions,
      :check_exemptions,
      :grid_reference,
      :organisation_type,

      # BRANCH
      :local_authority,
      :local_authority_postcode,

      :individual_postcode,
      :individual_name,
      :individual_postcode,



      :main_contact_name,
      :main_contact_telephone,
      :main_contact_email,
      :main_contact_address,
      :applicant_contact,
      :applicant_contact_name,
      :applicant_contact_telephone,
      :applicant_contact_email,
      :reviewing,
      :confirmation,
      :complete
    ]

  end

  # To avoid multiple occurrences of the same transition being defined
  # On first definition, state_machines will not be defined
  state_machines.clear if respond_to?(:state_machines)

  state_machine initial: DatashiftState.journey_plan_class.journey.first do

    create_back_transitions(DatashiftState.journey_plan_class.journey, [:complete])

    create_next_transitions(DatashiftState.journey_plan_class.journey)
end

end
