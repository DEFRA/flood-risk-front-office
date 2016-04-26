class CorrespondenceContactEmailPage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :correspondence_contact_email

  attr_reader :field_filled_wth

  def generate_data
    Faker::Internet.email
  end

  def form_email_field
    "correspondence_contact_email_email_address"
  end

  def form_confirmation_field
    "correspondence_contact_email_email_address_confirmation"
  end

  def fill_page_with(email, confirmation = nil)
    fill_in form_email_field, with: email

    @field_filled_wth = email

    conf = confirmation.nil? ? email : confirmation
    fill_in form_confirmation_field, with: conf
  end

  def fill_page
    fill_page_with(generate_data)
  end

  def advance_page_with(email, confirmation = nil)
    visit_page
    fill_page_with(email, confirmation)
    submit
  end

  def advance_page
    advance_page_with generate_data
  end

  def confirmation_field_matches_email(value = field_filled_wth)
    expect(find_field(form_email_field).value).to eq value
    expect(find_field(form_confirmation_field).value).to eq value
  end

end
