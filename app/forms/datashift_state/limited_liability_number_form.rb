module DatashiftState
  module Steps
    class LimitedLiabilityNumberForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :limited_liability_number


      def params_key
        :limited_liability_number
      end

      def save
        super
      end
    end
  end
end
