DigitalServicesCore::Enrollment.class_eval do

  class_attribute :state_transitions

  # The Array of transitions to dynamically build back and next events for linear journey

  def self.state_transitions
    @state_transitions ||= [
      :unregistered,
      :grid_reference,
      :add_exemptions,
      :check_exemptions,
      :user_type,
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


  # Set the Initial state here

  state_machine initial: :grid_reference do

    # Helper to get list of all transitions making up the journey

    def get_transitions
      DigitalServicesCore::Enrollment.state_transitions
    end

    # NEXT - Create a 'next' event for each step
    get_transitions.each_with_index do |t, i|
      break if t == :complete
      transition( { get_transitions[i] => get_transitions[i+1] }.merge(on: :next) )
    end

    # BACK - Create a 'back' event for each step
    get_transitions.each_with_index do |t, i|
      next if(t == :complete || i == 0) # no back allowed from here
      transition( {t => get_transitions[i - 1] }.merge(on: :back) )
    end

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
