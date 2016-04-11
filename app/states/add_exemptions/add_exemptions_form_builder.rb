module States
  module AddExemptionState

    class FormBuilder
      def self.call(enrollment)
        new.call enrollment
      end

      def call(enrollment)
          enrollment.exemptions = Exemption.all

          AddExemptionState::Form.new(enrollment)
      end
    end
  end
end

