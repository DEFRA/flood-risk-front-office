require_dependency "reform"

# Common step form functionality.
module DatashiftState
  module States
    class BaseForm < Reform::Form

      def initialize(model, journey_plan = nil)
        @journey_plan = journey_plan || model
        super(model)
      end

      # Moved knowledge of parent key in params (defined in the html form using as: ..
      # otherwise we get very longs form field names etc - see step1.html.erb)
      # since knowing how to extract the form data, and what the expectation of the
      # params sctructure is, is best here.
      # params_key is a symbol defined by the subclass
      def validate(params)
        super params.fetch(params_key) { {} }
      end

      attr_reader :journey_plan
    end
  end
end
