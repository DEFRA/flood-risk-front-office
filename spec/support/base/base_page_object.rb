require_relative "page_object_helpers"
require "capybara/dsl"

class BasePageObject
  include PageObjectHelpers
  extend PageObjectHelpers

  RSpec.configure do |_config|
    # this suggested form dont seems to work for latest version of Rails/rspec
    # config.include Rails.application.routes.url_helpers
    # but simply using standard module inclusion does the trick
    include Rails.application.routes.url_helpers

    Rails.application.routes.default_url_options = { host: "www.example.com" }
  end

  include RSpec::Matchers
  include Capybara::DSL

  # The main Registration object
  attr_accessor :enrollment

  def initialize
    @enrollment = nil
  end

  # Shortcut to the Engine routes
  def fre_url_helper
    FloodRiskEngine::Engine.routes.url_helpers
  end

  # Default - relies on PageObject utilising the 'generate_state_helpers' method
  # so we can create correct enrollment object and jump straight to right page
  def visit_page
    find_enrollment

    Rails.logger.debug("RSPEC : VISITING state [#{enrollment.step}] with Enrollment #{enrollment.inspect}")

    visit fre_url_helper.enrollment_step_path(enrollment, expected_state)

    self
  end

  def visit_state(state)
    visit fre_url_helper.enrollment_step_path(enrollment, state)
  end

  def find_enrollment
    if enrollment.nil? || enrollment.new_record?
      @enrollment = if respond_to?(:create_related_enrollment)
                      create_related_enrollment
                    else
                      FloodRiskEngine::Enrollment.new
                    end
    else
      @enrollment.reload
    end
    @enrollment
  end

  def submit
    click_button("Continue")
  end

  def click_back_link
    click_link(I18n.t("back"))
  end

  # Default advance - fill out page and click submit
  # fill_page  - expect derived to define this - this should not call Submit
  #
  def advance_page
    visit_page unless current_path && has_text?(self.class.on_page_text)
    fill_page
    submit
    find_enrollment
  end

  def dump
    print page.html
  end

  # requires test has :  js: true
  # rubocop:disable Debugger
  def screenshot(timestamp = "%H%M%S%L")
    file = "/tmp/rspec_po_#{Time.zone.now.strftime(timestamp)}.png"
    save_screenshot(file, full: true)
    puts "RSPEC created screenshot of current page #{file}"
  end
end
