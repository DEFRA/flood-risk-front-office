require_relative "../base/base_page_object"

class CheckLocationPageObject < BasePageObject
  generate_state_helpers :check_location

  # The ids of radio buttons on the form - creates helpers like
  #     verify_nothing_selected, choose_yes_option, advance_via_radio_yes_option
  #
  radio_button_helpers [:check_location_location_check_yes, :check_location_location_check_no]

  def expect_yes_to_be_checked
    expect(find('#check_location_location_check_yes')).to be_checked
  end

  def expect_yes_to_not_be_checked
    expect(find('#check_location_location_check_yes')).to_not be_checked
  end

  def expect_no_to_not_be_checked
    expect(find('#check_location_location_check_no')).to_not be_checked
  end

  def advance_page(yes = true)
    visit_page unless current_path && has_text?(CheckLocationPageObject.on_page_text)
    yes ? advance_via_radio_check_location_location_check_yes : advance_via_radio_check_location_location_check_no
  end
end
