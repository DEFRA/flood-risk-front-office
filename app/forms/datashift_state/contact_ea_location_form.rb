module DatashiftState
  module Steps
    class ContactEaLocationForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform


      def params_key
        :contact_ea_location
      end

      def save
        super
      end
    end
  end
end
