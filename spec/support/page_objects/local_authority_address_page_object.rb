class LocalAuthorityAddressPage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :local_authority_address

  # Address data returned for Postcode supplied by LocalAuthorityPostcodePage will be:
  def test_address_hash
    @test_address_hash ||= [
      {
        "uprn" => "340116", "organisation" => "ENVIRONMENT AGENCY",
        "premises" => "HORIZON HOUSE", "street_address" => "DEANERY ROAD",
        "locality" => nil, "city" => "BRISTOL", "postcode" => "BS1 5AH"
        # LOCATION , "x"=>"358205.03", "y"=>"172708.07"
      },
      {
        "uprn" => "10091760640", "address" => "HARMSEN GROUP, TRIODOS BANK, DEANERY ROAD, BRISTOL, BS1 5AH",
        "organisation" => "HARMSEN GROUP", "premises" => "TRIODOS BANK", "street_address" => "DEANERY ROAD",
        "locality" => nil, "city" => "BRISTOL", "postcode" => "BS1 5AH"
        # LOCATION, "x"=>"358130.1", "y"=>"172687.87"
      }
    ]
  end

  # We arrive on the address page from a previousd page where we enter the Postcode
  # this allows us to test visting the page as if we entered the Postcde which returns data as per test_address_hash
  def visit_page
    find_enrollment

    VCR.use_cassette("visit_page_local_authority_address_search") do
      LocalAuthorityPostcodePage.new.advance_page
    end
    self
  end

  # This allows us to test visting the page as if we entered any Postcde
  def visit_page_with(postcode)
    find_enrollment

    VCR.use_cassette("visit_page_with_postcde_local_authority_address_search") do
      LocalAuthorityPostcodePage.new.advance_page_with(postcode)
    end
    self
  end

  def valid_but_no_results_postcode
    "BS99 9XX"
  end

  def form_field
    "address_match_selection"
  end

  def manual_address_link_text
    I18n.t(on_page_locale_key + ".manual_entry")
  end

  def expected_no_address_error
    I18n.t("flood_risk_engine.validation_errors.uprn.blank")
  end

  # Address drop down after a search - options indexes start at 1 and 1st element's Num addresses Found
  def select_option_address_index(idx = 2)
    option = find("##{form_field}").find(:xpath, "option[#{idx}]")
    option.select_option
    option
  end

  def advance_page
    advance_page_with(2)
  end

  def advance_page_with(idx = 2)
    visit_page unless current_path && has_text?(self.class.on_page_text)

    VCR.use_cassette("advance_page_local_authority_address_search") do
      select_option_address_index(idx)
      submit
    end
  end
end
