require "rails_helper"
module FloodRiskEngine
  RSpec.describe "CorrespondenceContact - Email" do
    let(:page_object) { CorrespondenceContactEmailPage.new }

    let(:form_class) { Steps::CorrespondenceContactEmailForm }

    context "Page Object" do
      it "has state helpers setup to check page text" do
        expect(
          CorrespondenceContactEmailPage.on_page_locale_key
        ).to eq ".flood_risk_engine.enrollments.steps.correspondence_contact_email.heading"

        expect(CorrespondenceContactEmailPage.on_page_text).to include "the email address of"
      end

      it "has state helpers setup to confirm the state we are testing" do
        expect(page_object.expected_state).to eq :correspondence_contact_email
      end

      it "renders the correct starting point" do
        page_object.visit_page
        expect(page).to be_on_page_object page_object
      end
    end

    context "Given I'm on the Correspondence (Main) Contact Email page" do
      before(:each) do
        page_object.visit_page
      end

      scenario "When I enter my valid email address" do
        page_object.advance_page
        expect(Enrollment.last.correspondence_contact.email_address).to eq page_object.field_filled_wth
      end
    end

    context "When revisiting this page (after a succesful submission), via back button or review page " do
      scenario "Then the email confirmation field should display the current email" do
        page_object.advance_page

        expect(page).to_not be_on_page_object page_object

        page_object.click_back_link

        expect(page).to be_on_page_object page_object

        page_object.confirmation_field_matches_email
      end

      scenario "Then if I don't enter an email in correct format, Then I expect to see error" do
        page_object.advance_page

        expect(page).to_not be_on_page_object page_object

        page_object.click_back_link

        ["t@", "@env.com", "e@e"].each do |e|
          page_object.advance_page_with e
          expect(page).to be_on_page_object page_object

          expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.email_address.format")

          expect(page).to have_error_anchors :email_address
        end
      end
    end

    context "Validation" do
      scenario "When I don't enter an email, Then I expect to see error" do
        page_object.advance_page_with("")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.email_address.blank")

        expect(page).to have_error_anchors :email_address
      end

      scenario "When I don't enter an email in correct format, Then I expect to see error" do
        ["t@", "@env.com", "e@e"].each do |e|
          page_object.advance_page_with e
          expect(page).to be_on_page_object page_object

          expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.email_address.format")

          expect(page).to have_error_anchors :email_address
        end
      end

      scenario "When I don't enter a confirmation, Then I expect to see error" do
        page_object.advance_page_with(page_object.generate_data, "")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.email_address_confirmation.blank")

        expect(page).to have_error_anchors :email_address_confirmation
      end

      scenario "When I don't enter a confirmation that matches email, Then I expect to see error" do
        page_object.advance_page_with(page_object.generate_data, "blah#{Time.current}@blah.co.uk")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.email_address_confirmation.format")

        expect(page).to have_error_anchors :email_address_confirmation
      end
    end
  end
end
