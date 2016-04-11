require "reform/form/active_model/validations"

Reform::Form.class_eval do
  feature Reform::Form::ActiveModel::Validations
end

module States
  module GridReferenceState

    class Form < Reform::Form

      include Reform::Form::ActiveRecord

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
      property :grid_reference

      validates :grid_reference, presence: true#, uniqueness: true

      def save_enrollemt(enrollment)
        save

        enrollment.grid_reference = model

        enrollment.save
      end
    end
  end
end
