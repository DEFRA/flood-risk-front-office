module FloodRiskEngine
  module Steps
    class MainContactEmailForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
      property :email_address

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact || DigitalServicesCore::Contact.new
        new(contact, enrollment)
      end

      def params_key
        :main_contact_email
      end

      def save
        super
      end
    end
  end
end
