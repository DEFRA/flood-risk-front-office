class ApplicationController < FloodRiskEngine::ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper FloodRiskEngine::ApplicationHelper

  def user_not_authorized(_exception)
    logger.info("Pundit::NotAuthorizedError was raised - attempt to update complete Enrollment")
  end
end
