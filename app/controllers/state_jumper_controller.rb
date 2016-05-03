# This is a development tool - for creating and jumping straight to an Enrollment
# For a full list of available factories you can call :
#
#   FactoryGirl.definition_file_paths.inspect
#
#   FactoryGirl.factories.collect(&:name).inspect
#
unless Rails.env.production?

  require "factory_girl"
  require "faker"

  class StateJumperController < ApplicationController

    def build_and_display
      # Get weird problems with factories with has_many associations, when they've already been used,
      # so while obviously not very efficient, this seems to prevent that issue
      FactoryGirl.reload

      Rails.logger.debug("State jumper called - building Enrollment from factory #{params['factory']}")
      enrollment = FactoryGirl.create(params["factory"])
      state = params["state"] || enrollment.current_step
      redirect_to flood_risk_engine.enrollment_step_path(enrollment, state)
    end

  end

end
