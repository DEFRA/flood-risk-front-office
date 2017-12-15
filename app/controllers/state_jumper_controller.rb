# This is a development tool - for creating and jumping straight to an Enrollment
# For a full list of available factories you can call :
#
#   FactoryBot.definition_file_paths.inspect
#
#   FactoryBot.factories.collect(&:name).inspect
#
unless Rails.env.production?

  require "factory_bot"
  require "faker"

  class StateJumperController < ApplicationController

    def build_and_display
      # Get weird problems with factories with has_many associations, when they've already been used,
      # so while obviously not very efficient, this seems to prevent that issue
      FactoryBot.reload

      Rails.logger.debug("State jumper called - building Enrollment from factory #{params['factory']}")
      enrollment = FactoryBot.create(params["factory"])

      state = params["state"] || enrollment.current_step
      Rails.logger.debug("Jumping #{enrollment.inspect} to STATE [#{state}]")

      cookies.encrypted[:journey_token] = { value: enrollment.token }

      redirect_to flood_risk_engine.enrollment_step_path(enrollment, state)
    end

  end

end
