module FloodRiskRspec
  class Exception < StandardError
    def initialize(msg)
      super
      Rails.logger.error(msg)
    end

    def self.generate(name)
      new_class = Class.new(Exception) do
        def initialize(msg)
          super(msg)
        end
      end

      FloodRiskRspec.const_set(name, new_class)
    end
  end
end

FloodRiskRspec::Exception.generate("RadioButtonNotFound")
