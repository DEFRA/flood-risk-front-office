class ApplicationController < ::DigitalServicesCore::ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized(exception)
    logger.info("Pundit::NotAuthorizedError was raised - attempt to update complete Enrollment")

    if @enrollment
      @enrollment.errors.add :base, "Cannot update a Complete Exemption Registration"

      redirect_to digital_services_core.enrollment_state_path("complete", @enrollment)
    end
  end

end
