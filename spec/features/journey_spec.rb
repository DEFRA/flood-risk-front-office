require "rails_helper"
# This spec tests the journey from start to declaration for each organisation
# type, to ensure that each step is visited and leads to the expected next step.
RSpec.feature "Journey for organisation", type: :feature do
  FloodRiskEngine::Organisation.org_types.each_key do |organisation_type|
    # Get the sequence of steps expected for the current organisation type
    work_flow = FloodRiskEngine::WorkFlow::Definitions.send(organisation_type.to_sym)

    scenario "'#{organisation_type}' via steps: #{work_flow.to_sentence}" do
      enrollment = FactoryBot.create :enrollment, "with_#{organisation_type}".to_sym

      if organisation_type == "partnership"
        # Partnerships need a couple of partners for the journey to complete
        enrollment.organisation.partners << FactoryBot.create(:partner_with_contact)
        enrollment.organisation.partners << FactoryBot.create(:partner_with_contact)
      end

      # This test checks that the journey works from start to finish. As each
      # form is tested individually we are not interested here in testing specific
      # data input, just that if the data input is successful that the journey
      # continues to the next step
      allow_any_instance_of(FloodRiskEngine::Steps::BaseForm).to receive(:save).and_return(true)
      allow_any_instance_of(FloodRiskEngine::Steps::BaseForm).to receive(:validate).and_return(true)

      # This effectively mocks the setting of the journey token
      allow_any_instance_of(FloodRiskEngine::ApplicationController)
        .to receive(:journey_tokens)
        .and_return([enrollment.token])

      # Mock some processes triggered along the way.
      allow_any_instance_of(FloodRiskEngine::UpdateWaterManagementAreaJob).to receive(:perform).and_return(true)
      mock_ea_address_lookup_find_by_uprn
      mock_ea_address_lookup_find_by_postcode

      # Start the journey at the first step
      initial_step = work_flow.shift
      enrollment.update_attribute(:step, initial_step)
      visit "/enrollments/#{enrollment.token}/steps/#{initial_step}"

      # Each time the submit button is clicked, we should move to the next
      # step in the work flow.
      work_flow.each do |next_step|
        find('input[type="submit"]').click
        expect(current_path).to eql("/enrollments/#{enrollment.token}/steps/#{next_step}")
      end
    end
  end
end
