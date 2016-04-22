module DatashiftState
  module States
    class MainContactEmailForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :email
        property :confirm_email


      def params_key
        :main_contact_email
      end

      def save
        super
      end
    end
  end
end
