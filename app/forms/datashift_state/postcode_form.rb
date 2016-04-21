module DatashiftState
  module Steps
    class PostcodeForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :postcode
        property :premises
        property :street_address
        property :locality
        property :town
        property :manual_postcode


      def params_key
        :postcode
      end

      def save
        super
      end
    end
  end
end
