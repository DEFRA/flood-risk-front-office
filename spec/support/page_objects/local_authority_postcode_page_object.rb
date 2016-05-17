class LocalAuthorityPostcodePage < BasePageObject

  # Setup helpers to test whether we are 'on this page'
  generate_state_helpers :local_authority_postcode

  attr_reader :post_code_filled_wth

  def form_field
    "local_authority_postcode_post_code"
  end

  def valid_but_no_results_postcode
    "BS99 9XX"
  end

  def fill_page_with(post_code)
    @post_code_filled_wth = post_code
    fill_in form_field, with: post_code
  end

  def fill_page
    fill_page_with("BS1 5AH")
  end

  def advance_page_with(post_code)
    visit_page
    fill_page_with(post_code)
    submit
  end

  def advance_page
    advance_page_with "BS1 5AH"
  end

end
