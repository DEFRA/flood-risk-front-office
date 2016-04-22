module DatashiftState
  module States
    class GuidanceForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :what_doing
        property :what_wrong


      def params_key
        :guidance
      end

      def save
        super
      end
    end
  end
end
