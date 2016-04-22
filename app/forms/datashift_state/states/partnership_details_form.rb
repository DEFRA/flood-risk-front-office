module DatashiftState
  module States
    class PartnershipDetailForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform


      def params_key
        :partnership_details
      end

      def save
        super
      end
    end
  end
end
