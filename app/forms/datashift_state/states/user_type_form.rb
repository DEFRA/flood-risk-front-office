module DatashiftState
  module States
    class UserTypeForm < BaseForm

      def self.factory(journey_plan)
        new(journey_plan)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :local_authority
        property :limited_company
        property :limited_liability
        property :individual
        property :partnership
        property :other
        property :not_known


      def params_key
        :user_type
      end

      def save
        super
      end
    end
  end
end
