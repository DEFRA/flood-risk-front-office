module DatashiftState
  module Steps
    class EmailSomeoneElseForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :email
        property :confirm_email


      def params_key
        :email_someone_else
      end

      def save
        super
      end
    end
  end
end
