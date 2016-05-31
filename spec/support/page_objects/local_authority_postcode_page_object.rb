class LocalAuthorityPostcodePage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :local_authority_postcode

  attr_reader :post_code_filled_wth

  def form_field
    "local_authority_postcode_postcode"
  end

  def valid_but_no_results_postcode
    "BS99 9XX"
  end

  def fill_page_with(post_code)
    @post_code_filled_wth = post_code
    fill_in form_field, with: post_code
  end

  def default_search_postcode
    "BS1 5AH"
  end

  def fill_page
    fill_page_with default_search_postcode
  end

  def advance_page_with(post_code)
    visit_page
    fill_page_with(post_code)
    VCR.use_cassette("local_authority_postcode_page_search for #{post_code}") do
      submit
    end
  end

  def advance_page
    advance_page_with default_search_postcode
  end

end
