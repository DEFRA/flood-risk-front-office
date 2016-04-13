module FloodRiskEngine
  module Steps
    class UserTypeForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :organisation


      def self.factory(enrollment)
        new(enrollment)
      end

      def params_key
        :organisation
      end

      def save
        super
      end
    end
  end
end
