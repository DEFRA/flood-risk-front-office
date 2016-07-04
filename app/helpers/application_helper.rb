module ApplicationHelper

  def self.feedback_survey_url(current_title)
    survey_url = "https://www.smartsurvey.co.uk/s/floodexemptions/?"
    survey_params = { referringpage: current_title }
    survey_url + survey_params.to_query
  end

end
