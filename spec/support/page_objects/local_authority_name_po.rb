class LocalAuthorityNamePage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :local_authority

  attr_reader :name_filled_wth

  def form_field
    "local_authority_name"
  end

  def fill_page_with(name)
    @name_filled_wth = name
    fill_in form_field, with: name
  end

  def fill_page
    fill_page_with(Faker::Name.name)
  end

  def advance_page_with(name)
    visit_page
    fill_page_with(name)
    submit
  end

  def advance_page
    advance_page_with Faker::Name.name
  end

  def my_previous_details_are_remembered(name = @name_filled_wth)
    expect(find_field(form_field).value).to eq name
  end

end
