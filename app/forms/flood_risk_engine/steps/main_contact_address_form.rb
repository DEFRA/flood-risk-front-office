module FloodRiskEngine
  module Steps
    class MainContactAddressForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :postcode
        property :premises
        property :street_address
        property :locality
        property :city

      def self.factory(enrollment)
        address =  DigitalServicesCore::Address.new
        new(address, enrollment)
      end

      def params_key
        :main_contact_address
      end

      def save
        super
      end
    end
  end
end
