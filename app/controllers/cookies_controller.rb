class CookiesController < ApplicationController
  def accept_analytics
    write_cookie(:cookies_policy, :analytics_accepted)
    redirect_back fallback_location: root_path
  end

  def reject_analytics
    write_cookie(:cookies_policy, :analytics_rejected)
    redirect_back fallback_location: root_path
  end

  def hide_this_message
    write_cookie(:cookies_preferences_set, true)
    redirect_back fallback_location: root_path
  end

  def update
    # Google writes the cookies as ".hostname"
    # so we need to state the domain when removing
    cookies.to_hash.each_pair do |k, _v|
      cookies.delete k, domain: ".#{request.hostname}"
    end

    if params[:analytics] == "accept"
      write_cookie(:cookies_policy, :analytics_accepted)
    else
      write_cookie(:cookies_policy, :analytics_rejected)
    end
    write_cookie(:cookies_preferences_set, true)

    redirect_to page_path("cookies", cookies_updated: true)
  end

  protected

  def write_cookie(name, value)
    cookies[name] =
      {
        value: value,
        expires: 1.year
      }
  end
end
