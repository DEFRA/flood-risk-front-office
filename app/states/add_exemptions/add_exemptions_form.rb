module States
  module AddExemptionState

    class Form < Reform::Form
      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform

      collection :exemptions do
        property :code
      end


      def save_enrollemt(enrollment)
        save

       # Populate enrollment with  Exemption found where
       # "enrollment"=>{"enrollment"=>{"add_exemptions_id"=>"1"}}

        enrollment.save
      end
    end
  end
end
