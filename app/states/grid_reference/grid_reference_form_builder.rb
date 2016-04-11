module States
  module GridReferenceState

    class FormBuilder
      def self.call(enrollment)
        new.call enrollment
      end

      def call(enrollment)
          enrollment.grid_reference = GridReference.new

          GridReferenceState::Form.new(enrollment.grid_reference)
      end
    end
  end
end

