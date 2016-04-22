module DatashiftState
  module States
    class DeclarationConditionsPageForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform


      def params_key
        :declaration_conditions_page
      end

      def save
        super
      end
    end
  end
end
