module FloodRiskEngine
  module Steps

    class GridReferenceForm < FloodRiskEngine::Steps::BaseForm

      include Reform::Form::ActiveRecord

      def self.factory(enrollment)
        new(enrollment)
      end

      def params_key
        :add_exemptions_form
      end

      def save
        super
      end


      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
      property :grid_reference
      validates :grid_reference, presence: true#, uniqueness: true

    end
  end
end
