module DatashiftState
  module Steps
    class MainContactNameForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :full_name
        property :position


      def params_key
        :main_contact_name
      end

      def save
        super
      end
    end
  end
end
