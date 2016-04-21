DatashiftState.journey_plan_class.class_eval do

  class_attribute :journey

  # The Array of transitions to dynamically build back and next events for linear journey

  def self.journey
    @state_transitions ||= [
      :unregistered,
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

  # To avoid a ton of warnings when the state machine is re-defined
  StateMachines::Machine.ignore_method_conflicts = true

  # To avoid multiple occurrences of the same transition being defined
  # On first definition, state_machines will not be defined
  state_machines.clear if respond_to?(:state_machines)

  state_machine initial: DigitalServicesCore::Enrollment.journey.first do

    create_back_transitions(DigitalServicesCore::Enrollment.journey, [:complete])

    create_next_transitions(DigitalServicesCore::Enrollment.journey)

    # Allow any State to jump to reviewing
    event :review do
      transition from: all, to: :reviewing
    end

    after_transition any => :reviewing do |enrollment, _transition|
      Rails.logger.debug("Transition to reviewing - setting under_review flag")
      enrollment.update! under_review: true
    end

    after_transition to: :complete, do: :finalize!

    # Disallow transitions - cannot go back/change anything once Complete
    before_transition to: any - [:deregistered, :reviewing], from: :complete do
      raise RuntimeError.new("Transition not allowed - Registration COMPLETE")
    end

  end

  private

  # Hook called once Enrollment complete.
  # Likely place to trigger things like emails
  def finalize!
    return if submitted?
  end

end
