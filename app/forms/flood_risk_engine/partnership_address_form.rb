# This simple null form over rides validate/save etc so that it always succeeds so useful for
# 1. Testing a journey when you don't care what comes from view forms or how controller processes it
# 2. Use this form object for steps with no html form at all
#
module FloodRiskEngine
  module Steps
    class PartnershipAddressForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      def errors
          []
      end

      def save
          true
      end

      def validate(params)
          true
      end
    end
  end
end
