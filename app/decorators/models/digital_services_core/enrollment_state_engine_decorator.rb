StateMachines::Machine.class_eval do

  # BACK - Create a 'back' event for each step (apart from first) in journey
  # You can exclude any other steps with the except list
  #
  def create_back_transitions( journey, except = [] )
    journey.drop(1).each_with_index do |t, i|
      next if(except.include?(t))
      transition( {t => journey[i - 1] }.merge(on: :back) )
    end
  end

  # NEXT - Create a 'next' event for each step (apart from last) in journey
  # You can exclude  any other steps with the except list
  #
  def create_next_transitions( journey, except = [] )
    journey[0...-1].each_with_index do |t, i|
      next if(except.include?(t))
      transition( { journey[i] => journey[i+1] }.merge(on: :next) )
    end
  end
end

DigitalServicesCore::Enrollment.class_eval do

  class_attribute :state_transitions

  # The Array of transitions to dynamically build back and next events for linear journey

  def self.state_transitions
    @state_transitions ||= [
      :unregistered,
      :grid_reference,
      :add_exemptions,
      :check_exemptions,
      :organisation_type,
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

  state_machine initial: :grid_reference do

    create_back_transitions(DigitalServicesCore::Enrollment.state_transitions, [:complete])

    create_next_transitions(DigitalServicesCore::Enrollment.state_transitions)

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
