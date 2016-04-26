require "rails_helper"
module FloodRiskEngine
  RSpec.describe "CorrespondenceContact - Name" do
    let(:page_object) { CorrespondenceContactNamePage.new }

    let(:form_class) { Steps::CorrespondenceContactNameForm }

    context "Page Object" do
      it "has state helpers setup to check page text", duff: true do
        expect(
          CorrespondenceContactNamePage.on_page_locale_key
        ).to eq ".flood_risk_engine.enrollments.steps.correspondence_contact_name.heading"

        expect(CorrespondenceContactNamePage.on_page_text).to_not be_blank
      end

      it "has state helpers setup to confirm the state we are testing" do
        expect(page_object.expected_state).to eq :correspondence_contact_name
      end

      it "renders the correct starting point" do
        page_object.visit_page
        expect(page).to be_on_page_object page_object
      end
    end

    context "Given I'm on the Correspondence (Main) Contact Name page" do
      before(:each) do
        page_object.visit_page
      end

      scenario "When I enter my local authority or public body name" do
        page_object.advance_page
        expect(Enrollment.last.correspondence_contact.full_name).to eq page_object.name_filled_wth
      end
    end

    context "Navigating back from next page using back link " do
      scenario " When I click on the back link" do
        page_object.advance_page_with Faker::Name.name

        page_object.click_back_link

        expect(page).to be_on_page_object page_object

        page_object.my_previous_details_are_remembered
      end
    end

    context "Validation" do
      let(:validate_field) { "full_name" }

      scenario "When I don't enter a name, Then I expect to see error" do
        page_object.advance_page_with("")
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.#{validate_field}.blank")

        expect(page).to have_error_anchors :full_name
      end

      scenario "When I enter a very long name, Then I expect to see related error" do
        name = "this will is will blow" + "a" * form_class.name_max_length

        page_object.advance_page_with name
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("#{form_class.locale_key}.errors.#{validate_field}.too_long",
                                         max_length: page_object.name_max_length)

        expect(page).to have_error_anchors validate_field
      end

      scenario "When I enter a name with invalid characters, Then I expect to see related error" do
        name = "name *& 12"

        page_object.advance_page_with name
        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t("flood_risk_engine.validation_errors.#{validate_field}.invalid")
        expect(page).to have_error_anchors :full_name
      end

      scenario "When I enter a name with only acceptable non alpha characters, Then I don't expect to see error" do
        # letters, spaces, commas, full stops, hyphens and apostrophes
        name = "Joe Smith"

        page_object.advance_page_with name

        expect(page).to_not be_on_page_object page_object

        expect(page).to_not have_text I18n.t("flood_risk_engine.validation_errors.#{validate_field}.invalid")
        expect(page).to_not have_error_anchors :full_name
      end

      let(:position_max_length) { form_class.position_max_length }

      scenario "When I enter a very long position, Then I expect to see related error", duff: true do
        position = "role " + ("ab" * position_max_length)

        page_object.advance_page_with Faker::Name.name, position

        expect(page).to be_on_page_object page_object

        expect(page).to have_text I18n.t(
          "flood_risk_engine.enrollments.steps.correspondence_contact_name.errors.position.too_long",
          max_length: position_max_length
        )

        expect(page).to have_error_anchors "position"
      end
    end
  end
end
