class CookiesController < ApplicationController
  def accept_analytics
    write_cookie_and_redirect(:cookies_policy, :analytics_accepted)
  end

  def reject_analytics
    write_cookie_and_redirect(:cookies_policy, :analytics_rejected)
  end

  def hide_this_message
    write_cookie_and_redirect(:cookies_preferences_set, true)
  end

  protected

  def write_cookie_and_redirect(name, value)
    cookies[name] =
      {
        value: value,
        expires: 1.year
      }

    redirect_back fallback_location: root_path
  end
end
