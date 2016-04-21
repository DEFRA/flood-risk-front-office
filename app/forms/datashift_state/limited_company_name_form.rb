module DatashiftState
  module Steps
    class LimitedCompanyNameForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :company_name


      def params_key
        :limited_company_name
      end

      def save
        super
      end
    end
  end
end
