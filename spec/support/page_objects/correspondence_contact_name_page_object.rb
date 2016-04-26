class CorrespondenceContactNamePage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :correspondence_contact_name

  attr_reader :name_filled_wth

  def form_name_field
    "correspondence_contact_name_full_name"
  end

  def form_position_field
    "correspondence_contact_name_position"
  end

  def name_max_length
    FloodRiskEngine::Steps::CorrespondenceContactNameForm.name_max_length
  end

  def position_max_length
    FloodRiskEngine::Steps::CorrespondenceContactNameForm.position_max_length
  end

  def fill_position(position = Faker::Company.profession)
    fill_in form_position_field, with: position
  end

  # position is currently an optional field in GUI so we require tests where it is not filled in
  def fill_page_with(name, position = nil)
    @name_filled_wth = name
    fill_in form_name_field, with: name
    fill_position(position) unless position.nil?
  end

  def fill_page
    fill_page_with(Faker::Name.name)
  end

  # position is currently an optional field in GUI so we require tests where it is not filled in
  def advance_page_with(name, position = nil)
    visit_page
    fill_page_with(name)
    fill_position(position) unless position.nil?
    submit
  end

  def advance_page
    advance_page_with Faker::Name.name
  end

  def my_previous_details_are_remembered(name = @name_filled_wth)
    expect(find_field(form_name_field).value).to eq name
  end

end
