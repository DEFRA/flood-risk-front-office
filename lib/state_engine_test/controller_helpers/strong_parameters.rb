module StateEngineTest
  module ControllerHelpers
    module StrongParameters

      def permitted_attributes
        StateEngineTest::PermittedAttributes
      end

      delegate *StateEngineTest::PermittedAttributes::ATTRIBUTES,
               to: :permitted_attributes,
               prefix: :permitted


      def permitted_enrollment_attributes
        [
          :id,
          :states_grid_reference_state,
          states_grid_reference_state: [
            :grid_reference_form
          ],
          :add_exemptions_id
        ]
      end

    end
  end
end
