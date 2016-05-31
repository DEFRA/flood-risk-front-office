require "rails_helper"
module FloodRiskEngine
  RSpec.describe "CorrespondenceContact - Email" do
    let(:page_object) { LocalAuthorityPostcodePage.new }

    let(:form_class) { Steps::LocalAuthorityPostcodeForm }

    let(:params_key) { :local_authority_postcode }

    context "Page Object" do
      it "has state helpers setup to check page text" do
        expect(
          LocalAuthorityPostcodePage.on_page_locale_key
        ).to eq ".flood_risk_engine.enrollments.steps.#{params_key}.heading"

        expect(LocalAuthorityPostcodePage.on_page_text).to include "the main address of the local authority"
      end

      it "has state helpers setup to confirm the state we are testing" do
        expect(page_object.expected_state).to eq params_key
      end

      it "renders the correct starting point" do
        page_object.visit_page
        expect(page).to be_on_page_object page_object
      end
    end

    context "Given I'm on the LocalAuthority Postcode page" do
      before(:each) do
       # page_object.visit_page
      end

      scenario "When I enter a valid postcode I navigate to next page which displays post code and addresses" do
        page_object.advance_page

        expect(page).to have_link t("flood_risk_engine.enrollments.steps.local_authority_address.change")
      end
    end

    context "When revisiting this page, via back button or review page " do
      scenario "Then the post code should display the previous entry" do
        page_object.advance_page

        page_object.click_back_link

        expect(page).to be_on_page_object page_object

        expect(find_field(page_object.form_field).value).to eq page_object.default_search_postcode
      end
    end

    context "Validation" do
      scenario "When I don't enter a post code, Then I expect to see error" do
        page_object.advance_page_with("")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text t("flood_risk_engine.validation_errors.postcode.blank")
        expect(page).to have_error_anchors :postcode
      end

      scenario "When I enter an invalid postcode, Then I expect to see error" do
        ["BS", "BS6 %QA", "AAAA 2AA"].each do |e|
          page_object.advance_page_with e
          expect(page).to be_on_page_object page_object

          expect(page).to have_text t("flood_risk_engine.validation_errors.postcode.enter_a_valid_postcode")
          expect(page).to have_error_anchors :postcode
        end
      end

      describe "When I enter a valid postcode, and Postcode lookup is available to query" do
        scenario "And lookup returns no addresses", duff: true do
          page_object.advance_page_with(page_object.valid_but_no_results_postcode)

          expect(page).to be_on_page_object page_object # 1. Display postcode entry page again

          # 2. Echo entered postcode into lookup box (so user can check/edit postcode)
          expect(find_field(page_object.form_field).value).to eq page_object.valid_but_no_results_postcode

          # 3. Add error message:
          expect(page).to have_text t("flood_risk_engine.validation_errors.postcode.no_addresses_found")

          # 4. Add link to manual entry page with link text: "Enter address manually"
        end
      end
    end
  end
end
