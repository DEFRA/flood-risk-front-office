module FloodRiskEngine
  module Steps
    class MainContactTelephoneForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :phone_numbers

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact || DigitalServicesCore::Contact.new
        contact.phone_numbers << DigitalServicesCore::PhoneNumber.new
        new(contact, enrollment)
      end

      def params_key
        :main_contact_telephone
      end

      def save
        super
      end
    end
  end
end
