module DatashiftState
  module Steps
    class ApplicantContactNameForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :full_name


      def params_key
        :applicant_contact_name
      end

      def save
        super
      end
    end
  end
end
