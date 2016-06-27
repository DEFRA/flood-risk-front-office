require_relative "../base/base_page_object"

class CheckLocationPageObject < BasePageObject
  generate_state_helpers :check_location

  # The ids of radio buttons on the form - creates helpers like
  #     verify_nothing_selected, choose_yes_option, advance_via_radio_yes_option
  #
  radio_button_helpers [:yes_option, :no_option]

  def yes_checked?
    expect(find("#yes_option")).to be_checked
  end

  def no_checked?
    expect(find("#no_option")).to_not be_checked
  end

  def advance_page(yes = true)
    visit_page unless current_path && has_text?(CheckLocationPageObject.on_page_text)
    yes ? advance_via_radio_yes_option : advance_via_radio_no_option
  end
end
