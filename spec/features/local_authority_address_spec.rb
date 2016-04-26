require "rails_helper"
module FloodRiskEngine
  RSpec.describe "CorrespondenceContact - Email" do
    let(:page_object) { LocalAuthorityAddressPage.new }

    let(:form_class) { Steps::LocalAuthorityAddressForm }

    let(:params_key) { :local_authority_address }

    context "Page Object" do
      it "has state helpers setup to check page text" do
        expect(
          LocalAuthorityAddressPage.on_page_locale_key
        ).to eq ".flood_risk_engine.enrollments.steps.#{params_key}.heading"

        expect(LocalAuthorityAddressPage.on_page_text).to include "the main address of the local authority"
      end

      it "has state helpers setup to confirm the state we are testing" do
        expect(page_object.expected_state).to eq params_key
      end

      it "renders the correct starting point" do
        page_object.visit_page
        expect(page).to be_on_page_object page_object
      end
    end

    context "Given I'm on the LocalAuthority Address page" do
      before(:each) do
        page_object.visit_page
      end

      scenario "When I enter a valid address I navigate to next page" do

        page_object.advance_page

        enrollment = Enrollment.last

        expected_address_attributes =  page_object.test_address_hash[0]

        assert_record_values(enrollment.organisation.primary_address, expected_address_attributes)

        expect(enrollment.organisation.primary_address.addressable_id).to eq enrollment.organisation.id

        expect(page).to have_text t("flood_risk_engine.enrollments.steps.#{enrollment.step}.heading")
      end
    end

    context "When revisiting this page, via back button or review page " do
      scenario "Then the post code should be displayed from previous selection" do
        page_object.advance_page

        page_object.click_back_link

        expect(page).to be_on_page_object page_object

        expect(page).to have_text Enrollment.last.organisation.primary_address.postcode

        # TODO - how to check the option list is there and populated with 2 addresses?
      end
    end

    context "Validation" do
      scenario "When I don't select an Address, Then I expect to see error" do
        page_object.advance_page_with(1)
        expect(page).to be_on_page_object page_object

        expect(page).to have_text page_object.expected_no_address_error
        expect(page).to have_error_anchors :uprn
      end
    end

  end
end
