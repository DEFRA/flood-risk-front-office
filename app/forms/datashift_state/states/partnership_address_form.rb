module DatashiftState
  module States
    class PartnershipAddressForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :partnership_name
        property :premises
        property :street_address
        property :locality
        property :city
        property :manual_postcode


      def params_key
        :partnership_address
      end

      def save
        super
      end
    end
  end
end
