class CheckLocationPageObject < BasePageObject
  state :check_location

  # the ids of radio buttons on the form - creates helpers like
  #     verify_nothing_selected, assign_yes_option
  #
  radio_button_helpers [:yes_option, :no_option]

  # this is actually the root page, prior to the real journey
  def visit_page
    find_enrollment

    visit root_path
  end

  def yes_checked?
    expect(find('#yes_option')).to be_checked
  end

  def no_checked?
    expect(find('#no_option')).to_not be_checked
  end

  def advance_page(yes = true)
    visit_page unless current_path && has_text?(CheckLocationPageObject.on_page_text)
    yes ? assign_yes_option : assign_no_option
  end
end
