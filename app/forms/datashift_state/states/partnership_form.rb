module DatashiftState
  module States
    class PartnershipForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :full_name


      def params_key
        :partnership
      end

      def save
        super
      end
    end
  end
end
